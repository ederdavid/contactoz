class Service < Feed
	belongs_to :company
	belongs_to :contact
        acts_as_taggable
        named_scope :by_date, :order => "created_at DESC"
	named_scope :most_recent, :order => "created_at DESC LIMIT 20"
       has_many :topics, :through => :categorizations
        has_many :categorizations
end
