module LessCurse
  module Widgets
    class Base
      attr_accessor :data
      attr_accessor :title
      attr_accessor :focus

      def initialize data: nil, title: ""
        @data, @title = data, title
      end

      # Refresh portions of screen, probably using ncurses primitives
      def refresh ; end

      # Handle input or return false if doesnt care
      def handle_input key
        false
      end

      # Receive Focus
      def focus
        @focus = true
      end

      # Loose Focus
      def unfocus
        @focus = false
      end

      # Is focused?
      def focused?
        return @focus
      end
    end
  end
end
