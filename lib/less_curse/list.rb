module LessCurse
  class List
    attr_accessor :data
    attr_accessor :on_select

    def refresh
      window = LessCurse.screen.windows[self]
      FFI::NCurses.box window, 0, 0
      #FFI::NCurses.mvwaddstr(window, 0, 1, "Hello there")
      @data.each_with_index do |d, idx|
        FFI::NCurses.wmove window, idx + 1, 1
        FFI::NCurses.waddstr window, d.to_s
      end
    end
  end
end
