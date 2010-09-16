class Company < ActiveRecord::Base
        has_many :company_locations
	has_many :contacts
	acts_as_taggable_on :industries, :products, :services

        has_many :topics, :through => :company_categorizations
        has_many :company_categorizations

end
