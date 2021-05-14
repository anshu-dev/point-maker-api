class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  include FirestoreConcern

  validates_uniqueness_of :email, :username
  validates_presence_of :email, :username

  after_save :update_firestore

  has_many :points

  class << self
    def authenticate(username, password)
      user = User.find_for_authentication(email: username)
      user.try(:valid_password?, password) ? user : nil
    end
  end

  def firestore_data
    {
      email: self[:email],
      username: self[:username]
    }
  end
end
