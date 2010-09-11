class Product < ActiveRecord::Base
	belongs_to :company
	belongs_to :contact
        acts_as_taggable
        named_scope :by_date, :order => "created_at DESC"
	has_many :topics
end
