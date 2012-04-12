class User < ActiveRecord::Base
  
  has_and_belongs_to_many :roles
  belongs_to :employee
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable

  attr_accessor :login
  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :username, :email, :password, :password_confirmation, :remember_me, :employee_id, :role_ids
  
  #
  # Override this method to allow sign_in with username
  #
  def self.find_for_database_authentication(warden_conditions)
   conditions = warden_conditions.dup
   login = conditions.delete(:login)
   where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.strip.downcase }]).first
 end
 
 #
  # This method returns a string with all roles of the user
  # separated by comma ','.
  #
  def full_roles
    r = ''
    if @roles
      @roles.each do |role|
        r += (role.name+",")
        puts role.name
      end
    end
    r
  end
 
end
