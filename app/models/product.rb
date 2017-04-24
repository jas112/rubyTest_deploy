class Product < ActiveRecord::Base

  belongs_to :user
  has_many :transactions

  validates :name, :price, :presence => true
end
