module LessCurse
  module Geometry
    class Point
      attr_accessor :x, :y
      def initialize(x, y)
        @x, @y = x, y
      end
    end

    class Size
      attr_accessor :width, :height
      def initialize(width, height)
        @width, @height = width, height
      end
    end

    class Rectangle
      attr_accessor :position, :size
      def initialize(x, y, width, height)
        @position, @size = Point.new(x, y), Size.new(width, height)
      end
    end
  end
end
