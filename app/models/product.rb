class Product < Feed 
	belongs_to :company
	belongs_to :contact
        acts_as_taggable
end
