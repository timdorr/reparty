require 'active_record'

module Reparty
  class Report
    class ActiveRecord < Report
      attr_reader :model, :operation, :field

      def initialize(*args, &block)
        super(args.shift)

        if args.first.is_a?(Symbol)
          @model = Kernel.const_get(args.first.to_s.capitalize)
        elsif args.first.is_a?(::ActiveRecord::Relation)
          @model = args.first
        else
          raise "Report::ActiveRecord: model undefined"
        end

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
          7.downto(1).map { |x| @model.where("#{@field.to_s} < ?", DateTime.now.at_midnight-x).send(:count, @field) }
        else
          7.downto(1).map { |x| @model.where("DATE(#{@field.to_s}) = ?", DateTime.now.to_date-x).send(@operation, @field) }
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