class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  has_many :assignments
  has_many :roles, :through => :assignments
  
  validates_uniqueness_of :email
  
  
  def self.create_user(role_list, email, password, password_confirmation)
    new_user = User.new(:email => email, :password => password, :password_confirmation => password_confirmation)
    
    if not new_user.save
      return nil
    end
    
    # job_attachment = JobAttachment.create(:user_id => new_user.id, :office_id => self.id)
    
    role_list.each do |role|
      Assignment.create_role_assignment_if_not_exists( role,  new_user)
    end
    
    return new_user
  end
  
 
  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end
  
  
end
