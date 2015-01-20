require 'dicom'
require 'zip'
require 'tempfile'
include DICOM

class StudiesController < ApplicationController

  include ActionController::Live
  
  def index

  end

  def new
    @study = Study.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @study }
    end
  end

  def create
    response.headers['Content-Type'] = 'text/event-stream'

    @study = current_user.studies.new
    uploaded_io = params[:study][:upload]

    if uploaded_io.content_type.match('application/octet-stream') || uploaded_io.content_type.match('application/dicom')
      upload(uploaded_io.original_filename, uploaded_io.tempfile.path)
      # render nothing: true
    elsif uploaded_io.content_type.match('application/zip')
      Zip::File.open(uploaded_io.tempfile.path) do |zip_file| 
        zip_file.each do |entry|
          if entry.ftype.to_s.match(/directory/)

          else
            filepath = "/tmp/" + SecureRandom.hex
            entry.extract(filepath)
            upload(entry.name.split('/').last, filepath)
          end
        end
      end
      # render nothing: true
    else
      $redis.publish('study.error', "#{uploaded_io.original_filename} - Invalid file format")
      # flash[:danger] = "Invalid file Format"
      # redirect_to patient_path(params[:study][:patient_id])
      # render "patients/flash"
      # redirect_to "/patients/1.html"
    end
    render nothing: true
  end

  private
    def current_patient
      @patient = Patient.where(id: params[:study][:patient_id])
    end

    def studies_params
      params.require(:study).permit(:patient_id, :user_id, :study_uid, :created_at, :updated_at)
    end

    def upload (filename, path)
      node = DClient.new("192.168.1.13", 11112, ae: "HIPL", host_ae: "DCM4CHEE")
      dcm = DObject.read(path)
      @study.study_uid = dcm.value("0020,000D")
      @study.patient_id = params[:study][:patient_id] 
      existing_record = current_user.studies.find_by(study_uid: @study.study_uid)
      if !existing_record.nil?
        if existing_record[:patient_id] == @study.patient_id
          if !node.echo.nil?
            node.send(path)
            # respond_to do |format|
            if existing_record.update_attributes(:updated_at => (time = DateTime.now))
              study = JSON.parse(@study.to_json)
              study["filename"] = filename
              study["updated_at"] = time.strftime("%Y-%m-%d %H:%M:%S")
              $redis.publish('study.update', study.to_json)
             #  format.html {
             #    render :json => [@study.to_jq_upload].to_json, :content_type => 'text/html', :layout => false
             #  }
             #  format.json { 
             #   render json: {files: [@study.to_jq_upload]}, status: :created, location: @study 
             # }
            else
              flash[:danger] = "Connectivity problem"
              # format.html { render "patients/show" }
              # format.json { render json: @study.errors, status: :unprocessable_entity }
            end
          else
          end
          # end
        else
          flash[:danger] = "File not uploaded due to redunduncy!! Please check if the right patient profile is selected."
        end
      else
        node.send(path)
        # respond_to do |format|
          if @study.save
            study = JSON.parse(@study.to_json)
            study["filename"] = filename
            study["updated_at"]= DateTime.parse(study['updated_at']).strftime("%Y-%m-%d %H:%M:%S")
            $redis.publish('study.create', study.to_json)
            # format.html {
            #   render :json => [@study.to_jq_upload].to_json,
            #   :content_type => 'text/html',
            #   :layout => false
            # }
            # format.json { render json: {files: [@study.to_jq_upload]}, status: :created, location: @study }
          else
            flash[:danger] = "Connectivity problem"
            # format.html { render "patients/show" }
            # format.json { render json: @study.errors, status: :unprocessable_entity }
          end
        # end
      end
    end
    def recently_changed? last_study
      last_study.created_at > 5.seconds.ago or
        last_study.updated_at > 5.seconds.ago
    end

end