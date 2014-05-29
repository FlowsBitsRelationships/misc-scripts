require 'json'
require 'neography'

#DB_URL = 'http://localhost:7474/db/data/'
DB_URL = 'http://sg2014_1:s1YKo1Xbm62wn9uIcrR6@sg20141.sb02.stations.graphenedb.com:24789'

@neo = Neography::Rest.new( DB_URL )

def create_spatial_index
	@neo.create_spatial_index('tweets_1')
end


def load_tweets( filepath='/Users/ske/python/playground/sg2014/data/tweets_6.json' )
	all_tweets = nil
	File.open( filepath ) do | f |
		all_tweets = JSON.load( f.read )
	end

	all_tweets.each do | t |
		unless t['geo'].nil?
			node = @neo.create_node({ :username=> t['user']['name'], :text=>t['text'], :id=>t['id'], :lat=>t['geo']['coordinates'][0], :lon=>t['geo']['coordinates'][1] })
			@neo.add_node_to_spatial_index( 'tweets_1', node )
		end
	end
end

create_spatial_index
load_tweets

