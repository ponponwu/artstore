class Product < ActiveRecord::Base

	has_many :photos
	accepts_nested_attributes_for :photos
	belongs_to :category
	belongs_to :brand
end
