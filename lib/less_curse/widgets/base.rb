module LessCurse
  module Widgets
    class Base
      attr_accessor :data
      attr_accessor :title

      def initialize data: nil, title: ""
        @data, @title = data, title
      end

      # Refresh portions of screen, probably using ncurses primitives
      def refresh
        false
      end

      # Handle input or return false if doesnt care
      def handle_input
        false
      end
    end
  end
end
