# encoding: utf-8
require "logstash/outputs/base"
require "logstash/namespace"
require "logstash/json"

class LogStash::Outputs::Https < LogStash::Outputs::Base
	config_name "https"

    config :headers, :validate => :hash
    config :url, :validate => :string, :required => :true
    config :verb, :validate => ["put", "post"], :default => "post", :required => :true

	public
	def register
        require "net/http/persistent"

        @uri = URI.parse(@url)
        @agent = Net::HTTP::Persistent.new("logstash")
        @agent.reuse_ssl_sessions = true
        @agent.verify_mode = OpenSSL::SSL::VERIFY_NONE
	end

	public
	def receive(event)
		return unless output?(event)

        begin
			case @verb
				when "put"
					request = Net::HTTP::Put.new(event.sprintf(@uri.request_uri))
				when "post"
					request = Net::HTTP::Post.new(event.sprintf(@uri.request_uri))
				else
					@logger.error("Unknown verb: ", :verb => @verb)
			end

			if @headers
				@headers.each do |k,v|
					request[k] = event.sprintf(v)
				end
			end

			request["Content-Type"] = "application/json"
			request.body = event.to_json_with_metadata

            response = @agent.request(@uri, request)
            #puts response.code

        rescue Exception => e
            @logger.warn("Unhandled exception: ", :request => request, :response => response, :exception => e, :stacktrace => e.backtrace)
        end
	end # def encode

end # class LogStash::Outputs::Https
