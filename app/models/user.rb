class User < ActiveRecord::Base

  has_many :products
  has_many :transactions
  has_many :sales, :through => :products, :source => :transactions

  has_secure_password

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :password, :password_confirmation, :presence => true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }

  before_save :downcase_email

  private
  def downcase_email
    email.downcase! if email.present?
  end

end
