module LessCurse
  class Screen
    attr_accessor :widgets
    attr_accessor :windows
    attr_accessor :size
    attr_accessor :focused_widget

    def initialize
      # Need to initialize screen to access the terminal size
      FFI::NCurses.initscr

      @size = LessCurse::Geometry::Size.new(
        *FFI::NCurses::getmaxyx(FFI::NCurses::stdscr))
      @widgets = []
      @windows = {}
      @focused_widget = true
    end

    def add widget
      @widgets << widget
      @windows[widget] = new_window
    end

    def show
      #FFI::NCurses.initscr called in initialize
      FFI::NCurses.cbreak # can ctrl-c, not waiting for newlines to end input.
      FFI::NCurses.noecho # do not echo input in win.
      FFI::NCurses.keypad FFI::NCurses::stdscr, true # recognize KEY_UP etc.
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
