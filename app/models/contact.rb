class Contact < ActiveRecord::Base
  belongs_to :company
  has_many :industries
   has_many :services     
  has_many :products     
  has_many :contact_saveds
  has_many :users, :through => :contact_saveds

	def bought_by_user?(user)
		rtn = false
		rtn = user.contacts.include?(self) if user
	end

end
