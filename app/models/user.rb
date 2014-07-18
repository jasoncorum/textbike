class User < ActiveRecord::Base

	has_many :commutes, inverse_of: :user

	validates :phone,:presence => true,
            :numericality => true,
            :length => { :minimum => 10, :maximum => 10 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


end
