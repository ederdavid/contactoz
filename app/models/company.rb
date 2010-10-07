class Company < ActiveRecord::Base
        has_many :company_locations
	has_many :contacts
	acts_as_taggable_on :industries, :products, :services

        has_many :topics, :through => :company_categorizations
        has_many :company_categorizations

 def find_topics
        @topic = Topic.find(:all, :conditions => ['id in (select distinct topic_id from company_categorizations where company_id = ?)', self])
  end


def self.add_root
    @companies= Company.all
    for i in @companies
        @i = i
        @companyLocation = CompanyLocation.find_by_company_id(i.id)
        if @companyLocation != nil
            @i.root = true
            @i.save
        else
            @i.root = false
            @i.save
        end
    end
end



  def find_related_advertisements
               @topic_array = Array.new         
        	@topic = Topic.find(:all, :conditions => ['id in (select distinct topic_id from company_categorizations where company_id = ?)', self])

        	if @topic.nil?
	        	@topic_array = nil
		else
				
			for topic in @topic
				@topic_array << topic.id
			        #puts topic.id	
			end

		end

		@topic_array
                @related_advertisements = AdvertCategorization.find_by_topic_id(@topic_array)
  end


end
