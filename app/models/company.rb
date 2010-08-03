class Company < ActiveRecord::Base
        has_many :company_locations
	has_many :contacts
        has_many :services  
        has_many :products 
	acts_as_taggable_on :industries, :products, :services
end
