require 'mixpanel_client'

module Reparty
  class Report
    class Mixpanel < Report
      attr_reader :api_key, :api_secret, :report

      def initialize(*args, &block)
        super(args.shift, args.shift)

        @api_key = args.shift
        @api_secret = args.shift

        @report = args.shift
        case @report
          when :funnel
            @funnel_id = args.shift
        end

        @color = "#7548a2"
      end

      def client
        @client ||= ::Mixpanel::Client.new({api_key: api_key, api_secret: api_secret})
      end

      def funnel_data
        from_date = (DateTime.now-(interval*7)).strftime("%Y-%m-%d")
        to_date = (DateTime.now-1).strftime("%Y-%m-%d")

        @funnel_data ||= Hash[client.request(
            "funnels",
            {
                funnel_id: @funnel_id,
                interval: interval,
                from_date: from_date,
                to_date: to_date
            }
        )["data"].sort.reverse]
      end

      def engage_data
        @engage_data ||= client.request(
            "engage",
            {
                where: "properties[\"$last_seen\"] > \"#{1.day.ago.strftime("%Y-%m-%dT%H:%M:%S")}\""
            }
        )["results"]
      end
    end
  end
end