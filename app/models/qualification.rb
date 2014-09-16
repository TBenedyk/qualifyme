class Qualification < ActiveRecord::Base
	require 'open-uri'
	require 'json'

	serialize :country, Hash
	serialize :subjects_data, Array
	serialize :default_products, Array

	validates :key, :uniqueness => true, :presence => true

	API_PATH  	= "https://api.gojimo.net/api/v4/qualifications"

	class << self
		# Run 'Qualification.update_qualifications' to update qualification data (could be added as a rake task/cron job)
		def update_qualifications
			if last_updated && last_updated > last_modified
				puts "No new data :)"
			else
				qualifications = parse_url_data
				qualifications.each do |qualification|
					create_qualification(qualification)
				end
			end
		end

		def create_qualification(qualification)
			unless Qualification.find_by_key(qualification["id"])
				Qualification.create(
					:key 				=> qualification["id"],
					:name 				=> qualification["name"],
					:country 			=> qualification["country"],
					:subjects_data 		=> qualification["subjects"],
					:link				=> qualification["link"],
					:default_products 	=> qualification["default_products"])
			end
		end

		def parse_url_data
			JSON.parse(open(API_PATH).read)
		end

		def last_modified
			# Check last modified http header
			Date.parse(open(API_PATH){ |f| f.meta["last-modified"] })
		end

		def last_updated
			Qualification.order("updated_at DESC").first.try(:updated_at)
		end
	end

end
