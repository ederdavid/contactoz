class Company < ActiveRecord::Base
	has_many :contacts
	def searchContacts(c)
		@result = c.contacts
		if ActiveRecord::Rollback
			return @result = 0
		end
	end
end
