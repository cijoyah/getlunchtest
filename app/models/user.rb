class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :promotions, dependent: :destroy

  def valid_tel 
    if self.tel[0..2] == "+44"
      return self.tel
    else
     return "+44"+self.tel[1..-1]
   end
  end
    
end
