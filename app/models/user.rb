class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # That guest is the one who was active when user account got created
  belongs_to :guest, optional: true, foreign_key: "guest_uuid", primary_key: "uuid"
end
