module LessCurse
  class Screen
    attr_accessor :widgets
    attr_accessor :windows
    attr_accessor :size
    attr_accessor :focused_widget
    attr_accessor :header
    attr_accessor :footer

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
      recalc_window_sizes
    end

    def show
      @focused_widget = @widgets.last
      @focused_widget.focus if @focused_widget
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
      if @header && !@footer.empty?
        FFI::NCurses::mvaddstr 0, 0, @header
      end
      if @footer && !@footer.empty?
        FFI::NCurses::mvaddstr @size.height - 1, 0, @footer
      end

      @widgets.each {|widget| widget.refresh}
      @windows.each {|widget, window| FFI::NCurses.wrefresh window}
    end

    def focus_next
      focused_widget_idx = @widgets.index(@focused_widget) || 0
      @focused_widget.unfocus
      @focused_widget = @widgets[(focused_widget_idx + 1) % @widgets.size]
      @focused_widget.focus
    end

    def header= new_header
      @header = new_header
      recalc_window_sizes
    end

    def footer= new_footer
      @footer = new_footer
      recalc_window_sizes
    end

    private

    def recalc_window_sizes
      # Defaults to horizontal tiling
      equal_widths  = @size.width / (@widgets.size)
      header_height = (@header.nil? || @header.empty?) ? 0 : 1
      footer_height = (@footer.nil? || @footer.empty?) ? 0 : 1
      @widgets.each_with_index do |widget, idx|
        area = LessCurse::Geometry::Rectangle.new equal_widths * idx, #x
                                                  0 + header_height, #y
                                                  equal_widths - 1, #width
                                                  @size.height - header_height - footer_height #height
        if @windows[widget].nil?
          @windows[widget] = LessCurse.window area
        else
          FFI::NCurses.wresize(@windows[widget],
                               area.size.height, area.size.width)
          FFI::NCurses.mvwin(@windows[widget],
                             area.position.y, area.position.x)

        end
      end
    end

  end
end
