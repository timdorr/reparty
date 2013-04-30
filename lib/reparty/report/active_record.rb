module Reparty
  class Report
    class ActiveRecord < Report
      attr_reader :model, :operation, :field

      def initialize(*args, &block)
        super(args.shift)

        raise "Report::ActiveRecord: model undefined" unless args.first.is_a?(Symbol)
        @model = Kernel.const_get(args.first.to_s.capitalize)

        @operation = args.fetch(1, :count)
        @field = :created_at

        if args.last.is_a?(Hash)
          @field = args.last.fetch(:field, @field)
        end
      end

      def attach(attachments)
        @graph = build_daily_graph

        @graph.data(@model.to_s.pluralize, daily_dataset)

        attachments.inline["#{self.hash}.png"] = @graph.to_blob
      end

      def daily_dataset
        if @operation == :total
          7.downto(1).map { |x| @model.where("#{@field.to_s} < ?", DateTime.now-x).send(:count, @field) }
        else
          7.downto(1).map { |x| @model.where("DATE(#{@field.to_s}) = ?", DateTime.now-x).send(@operation, @field) }
        end
      end

      def yesterday
        op = @operation == :total ? :count : @operation
        @model.where("DATE(#{@field.to_s}) = ?", DateTime.now-1).send(op, @field)
      end

      def total
        op = @operation == :total ? :count : @operation
        @model.send(op, @field)
      end
    end
  end
end