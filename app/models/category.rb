class Category < ActiveRecord::Base
  has_many :products
  validates :name, presence: true, uniqueness: true
  # accepts_nested_attributes_for :products
  # validates_associated :products
end
