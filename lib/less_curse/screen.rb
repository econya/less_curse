module LessCurse
  class Screen
    attr_accessor :grid
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
      @windows = {}
      @focused_widget = nil
      @grid    = LessCurse::Grid.new [[]]
    end

    def add widget_or_grid
      if widget_or_grid.is_a? LessCurse::Grid
        @grid = widget_or_grid
      else
        @grid.add widget_or_grid
      end
      recalc_window_sizes
    end

    def widgets
      @grid.widgets
    end

    def show
      @focused_widget = widgets.first
      @focused_widget.focus if @focused_widget
      #FFI::NCurses.initscr called in initialize
      FFI::NCurses.cbreak # can ctrl-c, not waiting for newlines to end input.
      FFI::NCurses.raw    # TODO this overrides cbreak ...
      FFI::NCurses.noecho # do not echo input in win.
      FFI::NCurses.keypad FFI::NCurses::stdscr, true # recognize KEY_UP etc.
      FFI::NCurses.clear
      FFI::NCurses.box @windows[widgets[0]], 0, 0
      FFI::NCurses.refresh
      repaint
    end

    # Repaint the screen and all contained widgets
    def repaint
      FFI::NCurses.refresh

      # 'Draw' header and/or footer
      if @header && !@header.empty?
        FFI::NCurses::mvaddstr 0, 0, @header
      end
      if @footer && !@footer.empty?
        FFI::NCurses::mvaddstr @size.height - 1, 0, @footer
      end

      # Let all Widgets redraw themselfes
      widgets.each  do |widget|
        FFI::NCurses.wclear @windows[widget]
        widget.refresh
        FFI::NCurses.wrefresh @windows[widget]
      end
    end

    # Focus next element in #widgets
    def focus_next
      cycle_focus(+1)
    end

    # Focus next element in #widgets
    def focus_previous
      cycle_focus(-1)
    end

    # Set header text (first, top line of screen)
    def header= new_header
      @header = new_header
      recalc_window_sizes
    end

    # Set footer text (last, bottom line of screen)
    def footer= new_footer
      @footer = new_footer
      recalc_window_sizes
    end

    private

    # Switch focus to step next (or previous) widget
    def cycle_focus step=1
      focused_widget_idx = widgets.index(@focused_widget) || 0
      @focused_widget.unfocus
      @focused_widget = widgets[(focused_widget_idx + step) % widgets.size]
      @focused_widget.focus
    end

    def recalc_window_sizes
      header_height = (@header.nil? || @header.empty?) ? 0 : 1
      footer_height = (@footer.nil? || @footer.empty?) ? 0 : 1

      row_height = (@size.height - header_height - footer_height) / @grid.rows.count

      @grid.rows.each_with_index do |row_widgets, row_idx|
        element_width = @size.width / (row_widgets.size)
        row_y         = header_height + row_idx * row_height
        row_widgets.each_with_index do |widget, idx|
          area = LessCurse::Geometry::Rectangle.new element_width * idx, #x
                                                    row_y, #y
                                                    element_width - 1, #width
                                                    row_height #height
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
end
