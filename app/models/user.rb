class User < ActiveRecord::Base

	has_many :commutes, inverse_of: :user

	validates :phone_number, format: { with: ^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$
, message: "Please enter your \"Cell phone\" in this format: 5555555555" }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


end
