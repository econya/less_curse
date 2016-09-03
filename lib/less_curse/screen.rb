module LessCurse
  class Screen
    attr_accessor :widgets

    def initialize
      @widgets = []
    end

    def add widget
      @widgets << widget
    end

    def show
    end
  end
end
