class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    authorized_user = User.find_by(gateway: params[:session][:gateway])
    respond_to do |format|
      if authorized_user && authorized_user.authenticate(params[:session][:password])
        log_in authorized_user
        flash[:success] = "Welcome again, you logged in as #{authorized_user.name}"
        
        format.html {
          # log_in authorized_user
          # flash[:success] = "Welcome again, you logged in as #{authorized_user.name}"
          redirect_to(:controller => 'users', :action => 'index') 
        }
        format.json { render json: @patient }
        format.js { render js: "window.location = '#{users_path}'"}
      else

        format.html {
          flash[:danger] = "Invalid Username or Password"
          redirect_to root_path 
          }
        format.json { render json: @patient.errors }
        format.js { render js: "$('.alert-danger', $('.login-form')).show();"}
      end
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
