class Patient < ActiveRecord::Base
	# belongs_to :user
	# has_many :studies

	has_many :studies
	has_many :users, through: :studies

	validates :name, presence: true
	validates :address, presence: true
	validates :pincode, presence: true, numericality: { only_integer: true }, length: {is: 6}

end