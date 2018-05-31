module Cardreader	

	class Lang
		def initialize(key)
			@key = key
		end
	
		def post(text)
			uri = URI.parse("https://language.googleapis.com/v1beta1/documents:analyzeEntities?key=#{@key}")
	
			request = Net::HTTP::Post.new(uri)
			request.content_type = "application/json"
			request.body = ""
			request.body = "{
				'document':{
					'type':'PLAIN_TEXT',
					'content': '#{text}'
					}
			}"
	
			req_options = {
				use_ssl: uri.scheme == "https",
			}
	
			response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
				http.request(request)
			end
	
			JSON.parse(response.body)["entities"]
		end
	end
	
end
