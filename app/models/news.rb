class News < Feed
       has_many :topics, :through => :news_categorizations
        has_many :news_categorizations

end
