require 'httparty'

module Reparty
  class Report
    class Sendgrid < Report
      include HTTParty
      format :json
      headers 'Content-Type' => 'application/json', 'Accept' => 'application/json'

      attr_reader :api_user, :api_key

      def initialize(*args, &block)
        super(args.shift)

        @api_user = args.shift
        @api_key = args.shift

        @color = "#287abe"
      end

      def stats(today=DateTime.now)
        @stats ||= self.class.get(
            "https://sendgrid.com/api/stats.get.json?" +
            "api_user=" + @api_user +
            "&api_key=" + @api_key +
            "&start_date=" + today.utc.strftime("%Y-%m-%d") +
            "&days=6",
            options: { format: 'json' }
        )
      end
    end
  end
end