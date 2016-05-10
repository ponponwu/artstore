class Product < ActiveRecord::Base
	
	has_one :photo
	accepts_nested_attributes_for :photo
	belongs_to :category
	belongs_to :brand
end
