module Cardreader	

	class Manage
		def initialize(key)
			@vision = Vision.new(key)
			@lang = Lang.new(key)
			@results = {person: "", organization: "", location: "", 
	                mail: "", url: "", phone: ""}
		end
	
		def distill(keyword, reg)
			matched = @detected_text.match(reg)
	
			if matched
				matched = matched[0]
				@detected_text.gsub!(/#{matched.gsub(/\+/,'')}/, "")
				@results[keyword] = matched
			end
		end
	
		def preprocess
	    reg= /[^\s]+[\s]*(Corp|Ltd|Inc|Co|株式会社)/
			distill(:company, reg)
	
			reg = /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/
			distill(:mail, reg)
	
			reg =  /(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?/
			distill(:url, reg)
	
	    reg = /(\+[\dO]{2}[\-])?[\dO]{2,5}[\-(][\dO]{1,4}[\-)][\dO]{4}/
			distill(:phone, reg)
		end
	
		def detect(image)
			@detected_text = @vision.post(image)
			preprocess
			text = @lang.post(@detected_text)
			make(text)
		end
	
		def make(text)
			text.each do |t|
				case t["type"]
				when "PERSON"
					@results[:person] = t["name"]
				when "ORGANIZATION"
					@results[:organization] = " " + t["name"] + @results[:organization]
				when "LOCATION"
					@results[:location] = " " + t["name"] + @results[:location]
				else
				end
			end	
			@results.to_json
		end
	end
	
end	
