class User < ApplicationRecord
  acts_as_messageable # mailbox
  rolify # role managment
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :participants
  has_many :creases, through: :participants

  def name
    "User #{id}"
  end

  def mailboxer_email(object)
    nil
  end
end
