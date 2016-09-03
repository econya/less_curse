module LessCurse
  class Screen
    attr_accessor :widgets
    attr_accessor :windows
    attr_accessor :size

    def initialize
      # Need to initialize screen to access the terminal size
      FFI::NCurses.initscr

      @size = LessCurse::Geometry::Size.new(
        *FFI::NCurses::getmaxyx(FFI::NCurses::stdscr))
      @widgets = []
      @windows = {}
    end

    def add widget
      @widgets << widget
    end

    def show
    end
  end
end
