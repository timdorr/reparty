require 'mixpanel_client'

module Reparty
  class Report
    class MixpanelFunnel < Report
      attr_reader :funnel_id, :api_key, :api_secret

      def initialize(*args, &block)
        super(args.shift, args.shift)

        @funnel_id = args.shift
        @api_key = args.shift
        @api_secret = args.shift

        @color = "#7548a2"
      end

      def client
        @client ||= Mixpanel::Client.new({api_key: api_key, api_secret: api_secret})
      end

      def funnel_data
        from_date = (DateTime.now-(interval*7)).strftime("%Y-%m-%d")
        to_date = (DateTime.now-1).strftime("%Y-%m-%d")

        @funnel_data ||= client.request(
            "funnels",
            {
                funnel_id: funnel_id,
                interval: interval,
                from_date: from_date,
                to_date: to_date
            }
        )["data"]
      end
    end
  end
end