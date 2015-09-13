class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  before_save { self.email = email.downcase }


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: VALID_EMAIL_REGEX },
  uniqueness: { case_sensitive: false }


  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :city, presence: true, length: { maximum: 50 }
  validates :company, presence: true, length: { maximum: 50 }
  validates :position, presence: true, length: { maximum: 50 }
  validates :intro, presence: true, length: { maximum: 1000 }
  validates :country_code, presence: true
  validates :screen_name, presence: true, length: { maximum: 50 }
  validates :avatar, presence: true
  validates :need, presence: true
  validates :skill, presence: true




  has_many :conversations, :foreign_key => :sender_id


  has_attached_file :avatar, :styles => {:medium => "250x350#", :thumb => "50x50#" }, :default_url => "/images/:style/default_image.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


#paperclip save the original images with these two versions. After uploading the image, you can only call these two sizes
#rake paperclip:refresh CLASS=User -> refresh all style





# this method is put here becasue the method is dealing with db. all method dealing with database should be put in model, then let the controller to call it
#the objects inside these methods cant be called by the controller 
def find_users_matches_need
  col = []
  need.each do |n|
    if n.present? #empty string = not true 
      candidate_users = User.select(:id, :skill)
      candidate_users.each do |user|
        if user.skill.include? n
          col.push(User.find user.id)
        end
      end
    end
  end
  col
end



def find_users_matches_skill
  col = []
  skill.each do |s|
    if s.present?
      candidate_users = User.select(:id, :need)
      candidate_users.each do |user|
        if user.need.include? s
          col.push(User.find user.id)
        end
      end
    end
  end
  col
end


#def self.search(search)
#  where("first_name ILIKE ? OR country_code ILIKE ? OR city ILIKE ? OR company ILIKE ? OR company ILIKE ? OR position ILIKE ? OR intro ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%") 

#end



end
