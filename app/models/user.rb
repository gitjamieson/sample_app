class User < ActiveRecord::Base
  attr_accessible :name, :email

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :presence =>true,  #same as validates(:name,:presence=>true)
                                     #remember, last value set is returned by
                                     # default

                   :length =>{ :maximum => 50 }
  validates :email, :presence =>true,
            :format => { :with => email_regex } ,
            :uniqueness => { :case_sensitive => false }

end

# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

