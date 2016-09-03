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
      @windows[widget] = new_window
    end

    def show
      #FFI::NCurses.initscr called in initialize
      FFI::NCurses.cbreak # can ctrl-c
      FFI::NCurses.noecho
      FFI::NCurses.clear
      FFI::NCurses.box @windows[@widgets[0]], 0, 0
      FFI::NCurses.refresh
      repaint
    end

    def repaint
      FFI::NCurses.refresh
      @widgets.each {|widget| widget.refresh}
      @windows.each {|widget, window| FFI::NCurses.wrefresh window}
    end

    def new_window
      # Should default to horizontal tiling
      rectangle = LessCurse::Geometry::Rectangle.new 0, 0, 50, 15
      LessCurse::window rectangle
    end
  end
end
