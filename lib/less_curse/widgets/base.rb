module LessCurse
  module Widgets
    class Base
      attr_accessor :data
      attr_accessor :title
      attr_accessor :focus
      attr_accessor :actions

      def initialize data: nil, title: ""
        @data, @title = data, title
        set_default_actions
      end

      # Draw portions of screen, probably using ncurses primitives.
      # Expect an already clean/red window.
      def draw(window) ; end

      # Populate actions with proper code
      def set_default_actions ; end

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
