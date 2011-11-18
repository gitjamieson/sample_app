require 'digest'
class User < ActiveRecord::Base

  #create a virtual password attribute
  attr_accessor :password  

  attr_accessible :name, :email, :password, :password_confirmation

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :presence =>true,  #same as validates(:name,:presence=>true)
                                     #remember, last value set is returned by
                                     # default

                   :length =>{ :maximum => 50 }
  validates :email, :presence =>true,
            :format => { :with => email_regex } ,
            :uniqueness => { :case_sensitive => false }

  
  # the validates line below also creates a virtual password_confirmation 
  # attribue
  validates :password, :presence =>true,
                       :confirmation => true,
                       :length => { :within => 6..40 }

  before_save :encrypt_password

  # Return true if the users' password matches the submitted password
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)  # you can use find_by with any attribute
#================
# way one to right the test
#================
#    return nil if user.nil?
#    return user if user.has_password?(submitted_password) #if has pw, method
                                                          # returns true so
                                                          # user is returned 
#================
# way two to right the test
# if everything on right of ? is true, return user otherwise return nil
#================
     user && user.has_password?(submitted_password) ? user : nil
  end

  private

    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt (password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end  

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
      
end

# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#
