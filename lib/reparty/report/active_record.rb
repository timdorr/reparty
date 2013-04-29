module Reparty
  class Report
    class ActiveRecord < Report
      attr_reader :model

      def initialize(*args, &block)
        super(args.shift)

        raise "Report::ActiveRecord: model undefined" unless args.first.is_a?(Symbol)
        @model = Kernel.const_get(args.first.to_s.capitalize)

        @operation = :count
        case args.last.keys.first
          when :count
            @operation = :count
            @field = args.last.values.first
          when :sum
            @operation = :sum
            @field = args.last.values.first
        end if args.last.is_a?(Hash)
      end

      def total
        @model.send(@operation, @field)
      end
    end
  end
end