class Advertisement < ActiveRecord::Base
	         acts_as_taggable_on :industries
end
