class Contact < ActiveRecord::Base
  belongs_to :company

  def self.search(search,page)
    #if search

        #find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    #else
    #   find(:all)
    #end
  end

end
