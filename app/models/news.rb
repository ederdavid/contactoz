class News < Feed
       has_many :topics, :through => :news_categorizations
        has_many :news_categorizations

	def  self.read_feeds

               @fd = File.open("/Users/tina/Desktop/contact/config/rss2") 
		#@fd = File.open("/Users/tina/Desktop/contact/config/rss")
    		@JSONfeeds = ActiveSupport::JSON.decode(@fd.read)

  		for feed in @JSONfeeds.keys
                		for url in @JSONfeeds[feed]
				FeedEntry.update_from_feed(url)
                		end
            	end
	end


        def  self.tag

        end


end
