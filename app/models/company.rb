class Company < ActiveRecord::Base
        has_many :company_locations
	has_many :contacts
	acts_as_taggable_on :industries, :products, :services

        has_many :topics, :through => :company_categorizations
        has_many :company_categorizations

 def find_topics
        @topic = Topic.find(:all, :conditions => ['id in (select distinct topic_id from company_categorizations where company_id = ?)', self])
  end

def self.remove_dups

         @similar_companies = Company.find(:all,:conditions=> ['company_name LIKE ?', '%TELEVISION AZTECA%'])

i = 1

while i < @similar_companies.count

                        @newcomp = CompanyLocation.create(:company_id => @similar_companies[0].id, :phone_number => @similar_companies[i].company_phone, :scian => @similar_companies[i].scian, :colonia=> @similar_companies[i].colonia, :code => @similar_companies[i].company_postcode, :address=> @similar_companies[i].company_address, :city=> @similar_companies[i].company_city, :state => @similar_companies[i].company_state, :name=> @similar_companies[i].company_name, :site=>@similar_companies[i].company_site, :giro=> @similar_companies[i].giro)
                        @newcomp.save
                        puts "created location:" + @similar_companies[i].company_name
                        Company.destroy(@similar_companies[i].id)
                        puts "destroyed"
i = i + 1

end

end


def self.remove_root

@companies = Company.find(:all,:conditions=>[ 'root=?','t'])

#go through all root companies

	for acompany in @companies

	#find ones with similar company name

	@similar_companies = Company.find(:all,:conditions=>[ 'company_name LIKE ?', acompany.company_name])

	#create a companylocation and then delete company


		#create a new company then destroy all similar companies
	
		for similar_company in @similar_companies
		
			@newcomp = CompanyLocation.create(:code => similar_company.company_postcode, :address=> similar_company.company_address, :city=> similar_company.company_city, :state => similar_company.company_state, :name=> similar_company.company_name, :site=>similar_company.company_site, :giro=> similar_company.giro)
			@newcomp.save

                        if similar_company.id == acompany.id
			#don't destroy
			else
			Company.destroy(similar_company.id)
			end


		end

	end


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
