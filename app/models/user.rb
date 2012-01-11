# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  username   :string(255)
#  usertype   :integer
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation, :address, :dob, :lastname, :country, :city ,:phone ,:zip, :usertype,:notification,:active,:visit
  validates_uniqueness_of :email
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  word_regex  = /[a-z]+/i
  number_regex= /[\d]+/

  validates :email, :presence => true,
            :format   => { :with => email_regex },
            :length       => { :within => 0..50 }

# Validation For First Name - > Must be a word, max length can be 20 characters

  validates :name, :presence => true,
            :format   => { :with => word_regex },
            :length   => { :within => 0..70 }
# Validation For Last Name - > Must be a word, max length can be 20 characters
 validates :lastname, :presence => true,
            :format   => { :with => word_regex },
            :length   => { :within => 0..70}

  validates :address,
            :format   => { :with => word_regex },
            :length   => { :within => 0..100}


  validates :city,         :presence => true,
            :format   => { :with => word_regex },
            :length   => { :within => 0..30}

  validates :zip,         :presence => true,
            :format   => { :with => number_regex },
            :length   => { :within => 0..7}

  validates :dob,         :presence => true,
              :length   => { :within => 0..10}


  validates :phone,         :presence => true,
              :format   => { :with => number_regex },
              :length   => { :within => 9..20}

  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40}

  before_save :encrypt_password

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    return nil  if user.nil?
    return user if user.salt == cookie_salt
  end

  def report


  end

  private

    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
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
