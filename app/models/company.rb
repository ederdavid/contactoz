class Company < ActiveRecord::Base
	has_many :contacts
	has_many :industries     
        has_many :services  
        has_many :products 
end
