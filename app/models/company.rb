class Company < ActiveRecord::Base
<<<<<<< HEAD:app/models/company.rb
    has_many :contacts
=======
	has_many :contacts
	has_many :industries     
        has_many :services  
        has_many :products 
>>>>>>> 69bf54ef1f6af38a685f11d1593b5bc1bdc24dc5:app/models/company.rb
end
