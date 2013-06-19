require 'httparty'

module Reparty
  class Report
    class Sendgrid < Report
      include HTTParty
      format :json
      headers 'Content-Type' => 'application/json', 'Accept' => 'application/json'

      attr_reader :api_user, :api_key

      def initialize(*args, &block)
        super(args.shift, args.shift)

        @api_user = args.shift
        @api_key = args.shift

        @color = "#287abe"
      end

      def attach(attachments)
        @graph = build_daily_line_graph

        %W{requests delivered bounces spamreports}.each do |stat|
          @graph.data(stat.capitalize, stats.map{|s| s.fetch(stat,0)})
        end

        attachments.inline["#{self.hash}.png"] = @graph.to_blob
      end

      def stats(today=DateTime.now)
        @stats ||= self.class.get(
            "https://sendgrid.com/api/stats.get.json?" +
            "api_user=" + @api_user +
            "&api_key=" + @api_key +
            "&start_date=" + (today.utc.to_date - 1).strftime("%Y-%m-%d") +
            "&days=7",
            options: { format: 'json' }
        )

        @stats.pop if @stats.size == 8
        @stats
      end
    end
  end
end