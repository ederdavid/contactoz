class Service < Feed
	belongs_to :company
	belongs_to :contact
        acts_as_taggable
        has_many :topics, :through => :categorizations
        has_many :categorizations
end
