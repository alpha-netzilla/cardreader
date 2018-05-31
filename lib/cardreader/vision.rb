module Cardreader	

	class Vision
		def initialize(key)
			@key = key
		end
	
		def post(image)
			uri = "https://vision.googleapis.com/v1/images:annotate?key=#{@key}"
			base64_image = Base64.strict_encode64(File.new(image, 'rb').read)
			body = {
	  		requests: [{
	    		image: {
	      		content: base64_image
	    		},
	    		features: [
	      		{
	        		type: 'TEXT_DETECTION',
	        		maxResults: 1
	      		}
	    		]
	  		}]
			}.to_json
	
			uri = URI.parse(uri)
			https = Net::HTTP.new(uri.host, uri.port)
			https.use_ssl = true
			request = Net::HTTP::Post.new(uri.request_uri)
			request["Content-Type"] = "application/json"
			response = https.request(request, body)
	
			#text = JSON.parse(response.body)["responses"][0]["fullTextAnnotation"]["text"]
	
	
			blocks = JSON.parse(response.body)["responses"][0]["fullTextAnnotation"]["pages"][0]["blocks"]
	
			page = []
			blocks.each do |block|
				text = ""
				block["paragraphs"][0]["words"].each do |word|
				text += " "
					word["symbols"].each do |symbol|
						text += symbol["text"]
					end
				end
				page << text
			end
			return page.join("\n")
		end
	end
	
end	
	#cat vision.json | jq .fullTextAnnotation.pages[0].blocks[4].paragraphs[0].words[5].symbols[0]
