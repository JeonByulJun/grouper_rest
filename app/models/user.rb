class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :teams
  has_and_belongs_to_many :tasks
  has_and_belongs_to_many :chats
  has_many :whiteboard

  has_and_belongs_to_many :messages
end
