require 'nokogiri'
require 'open-uri'
require 'json'

class Scrapper


	PAGE_VAUREAL = "http://annuaire-des-mairies.com/95/vaureal.html"
	PAGE_VAL_DOISE = "http://annuaire-des-mairies.com/val-d-oise.html"


	def get_the_email_of_a_townhal_from_its_webpage (url_vaureal)

		page = Nokogiri::HTML(open(url_vaureal)) 
		mail = page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]")
		# array = []
		# array_end = array << mail.text

		puts mail.text
		return mail.text
		

	end

	def get_all_the_urls_of_val_doise_townhalls (url_valdoise)

		page = Nokogiri::HTML(open(url_valdoise))
		site = []
		site = page.css('a')

		array = []

		site.map do |y|
			if rege = y['href'] =~ (/95/)
				array << y['href']
			end
		end
		puts array

	end


	def all_mails_val_doise

		page = Nokogiri::HTML(open(PAGE_VAL_DOISE))
		site = []
		site = page.css('a')

		array = []

		site.map do |y|
			if rege = y['href'] =~ (/95/)
				array << y['href']
			end
		end
		array_email = []
		array.each do |adresse| 
			adresse[0] = "http://annuaire-des-mairies.com"


		array_email << get_the_email_of_a_townhal_from_its_webpage(adresse)

		end

		File.open("./db/emails.JSON", "w") do |f|
			f.write(array_email.to_json)
		end
	end

	def perform
	# scrapper = Scrapper.new
	self.all_mails_val_doise
	end


end

