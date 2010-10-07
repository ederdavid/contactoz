class FeedEntry < ActiveRecord::Base

 searchable do
    text    :name,  :boost=>2 
    text    :summary, :boost=>2 
    text    :content
   time    :published_at
  end


	def self.test_search
		@search = FeedEntry.search { keywords 'acerca mexico Monterrey', :minimum_match => 2 }
	end

require 'nokogiri'
require 'open-uri'


  def self.update_from_feed(feed_url)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries)
  end
  
  def self.update_from_feed_continuously(feed_url, delay_interval = 15.minutes)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries)
    loop do
      sleep delay_interval
      feed = Feedzirra::Feed.update(feed)
      add_entries(feed.new_entries) if feed.updated?
    end
  end


  def self.test_first

	@without_content = FeedEntry.find_all_by_content(nil)

	for feed in @without_content do
		@feed_url = feed.url.to_s
                puts "before url: " + @feed_url
 		doc = Nokogiri::HTML(open(@feed_url))
              
                if doc
		if @feed_url.include? "eleconomista"
				puts "includes eleconomista: " + @feed_url

 				@element = doc.at_css(".node").text
                                if @element
                                        feed.content = @element
                                        feed.save
                                end

		end

                if @feed_url.include? "proceso"
                                puts "includes eleconomista: " + @feed_url
				#.col_der
                                @element = doc.at_css("#divExclusivaContenido").text
                                if @element
                                        feed.content = @element
                                        feed.save
                                end

                end

                if @feed_url.include? "milenio"
                                puts "includes milenio: " + @feed_url

                                @element = doc.at_css("#parrafos").text
                                if @element
                                        feed.content = @element
                                        feed.save
                                end

                end


		 if @feed_url.include? "jornada"
                                puts "includes jornada: " + @feed_url

                                @element = doc.at_css("#article-cont").text
                                if @element
                                        feed.content = @element
                                        feed.save
                                end

                end

                 if @feed_url.include? "radioformula"
                                puts "includes radioformula: " + @feed_url

                                @element = doc.at_css(".corp_text").text
                                if @element
                                        feed.content = @element
                                        feed.save
                                end

                end

                 if @feed_url.include? "cnnexpansion"
                                puts "includes cnn: " + @feed_url

                                @element = doc.at_css("#cambiarFuente").text
                                if @element
                                        feed.content = @element
                                        feed.save
                                end

                end
                 if @feed_url.include? "newsforums.bbc.co"
                                puts "includes bbc news forum : " + @feed_url

                                @element = doc.at_css(".description").text
                                if @element
                                        feed.content = @element
                                        feed.save
                                end

                end

 		if @feed_url.include? "bbc.co.uk/blogs"
                                puts "includes bbc blog : " + @feed_url

                                @element = doc.at_css(".post_content").text
                                if @element
                                        feed.content = @element
                                        feed.save
                                end

                end

                 if @feed_url.include? "bbc.co.uk"

			# fix later
			if not @feed_url.include? "ws/es/" #fix later
			if not @feed_url.include? "blogs/mundo" #fix later
			# complete regular exp
			if not @feed_url.include? "radio/podcasts"
			if not @feed_url.include? "apps/ifl/spanish"
			if not @feed_url.include? "video"
                                puts "includes bbc : " + @feed_url

                                @element = doc.at_css(".bodytext").text
                                if @element
                                        feed.content = @element
                                        feed.save
                                end
			end
			end
			end
			end
			end
                end


                if @feed_url.include? "eluniversal.com.mx/notas"
                                puts "includes el universal : " + @feed_url


				content_string = ""
				doc.css(".a13g").each do |item|
                                        puts content_string
					content_string =  item.text + content_string
				end


                                if content_string
                                        feed.content = content_string 
                                        feed.save
                                end

                end

                 if @feed_url.include? "eluniversal"
                                puts "includes el universal : " + @feed_url

                                @element = doc.at_css(".noteText").text
                                if @element
                                        feed.content = @element
                                        feed.save
                                end

                end

                end 







	end

  end





  # delayed job
  def self.populate_body


require 'nokogiri'
require 'open-uri'


     #scraping_elements = {'proceso'=>'.txt_cajas', 'radioformula'=>'.corp_text' ,'jornada'=>'.article-cont .text'}

  	FeedEntry.find_all_by_content(nil).each do |feed|
		@feed_url = feed.url.to_s
		doc = Nokogiri::HTML(open(@feed_url))
                if doc
			breakpoint("FeedEntry#url") { @feed_url}

        		if @feed_url.include? "proceso"
                                @element = doc.at_css("#divExclusivaContenido").text
				if @element
      					feed.content = @element
					feed.save
				end
			end

			##to do: elfinanciero

                        #if feed_url.include? "cnnexpansion"
                        #        feed.update_attribute(:content, doc.at_css("#cambiarFuente").text)
                        #end

                        #if feed_url.include? "jornada"
                        #        feed.update_attribute(:content, doc.at_css("#article-cont").text)
                        #end
                        #if feed_url.include? "radioformula"
                        #        feed.update_attribute(:content, doc.at_css(".corp_text").text)
                        #end

                        #if feed_url.include? "milenio"
                        #        feed.update_attribute(:content, doc.at_css("#parrafos").text)
                        #end

                        #if feed_url.include? "milenio"
                        #        feed.update_attribute(:content, doc.at_css("#parrafos").text)
                        #end


                end
			
		end

  end
  
  private
  
  def self.add_entries(entries)
    entries.each do |entry|
      unless exists? :guid => entry.id
        create!(
          :name         => entry.title,
          :summary      => entry.summary,
          :url          => entry.url,
          :published_at => entry.published,
          :guid         => entry.id,
          :categories   => entry.categories,
          :content   => entry.content
        )
      end
    end
  end


end

