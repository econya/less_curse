module LessCurse
  class Screen
    attr_accessor :widgets
    attr_accessor :windows
    attr_accessor :size
    attr_accessor :focused_widget

    def initialize
      # Need to initialize screen to access the terminal size
      FFI::NCurses.initscr

      height,width =  FFI::NCurses::getmaxyx(FFI::NCurses::stdscr)
      @size = LessCurse::Geometry::Size.new(width,height)
      @widgets = []
      @windows = {}
      @focused_widget = nil
    end

    def add widget
      @widgets << widget
      #@windows[widget] = new_window
      new_window
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
      # Defaults to horizontal tiling
      equal_widths = @size.width / (@widgets.size)
      @widgets.each_with_index do |widget, idx|
        area = LessCurse::Geometry::Rectangle.new equal_widths * idx, #x
                                                  0, #y
                                                  equal_widths - 1, #width
                                                  @size.height #height
        if @windows[widget].nil?
          @windows[widget] = LessCurse.window area
        else
          FFI::NCurses.wresize(@windows[widget],
                               area.size.height, area.size.width)
          FFI::NCurses.mvwin(@windows[widget],
                             area.position.y, area.position.x)

        end
      end
      @focused_widget = @widgets.last
      @focused_widget.focus
    end

    def focus_next
      focused_widget_idx = @widgets.index(@focused_widget) || 0
      @focused_widget.unfocus
      @focused_widget = @widgets[(focused_widget_idx + 1) % @widgets.size]
      @focused_widget.focus
    end
  end
end
