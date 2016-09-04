module LessCurse
  module Widgets
    class Base
      attr_accessor :data
      attr_accessor :title

      def initialize data: nil, title: ""
        @data, @title = data, title
      end
    end
  end
end
