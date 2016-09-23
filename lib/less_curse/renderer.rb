module LessCurse
  module Renderer
    # Draw box and title in top border of box
    def self.box_with_title window, title
      FFI::NCurses.box window, 0, 0
      FFI::NCurses.mvwaddstr window, 0, 1, title
    end

    # Draw into lower border of a box
    def self.box_foot window, text
      height,width = FFI::NCurses::getmaxyx(window)
      FFI::NCurses.mvwaddstr window, height - 1, 1, text
    end

    # Write a line in window
    def self.write_line window, line_number, text
      FFI::NCurses.mvwaddstr window, line_number + 1, 1, text
    end

    # Switch on boldness depending on condition
    def self.bold_if condition, window
      if condition
        FFI::NCurses.wattron window, FFI::NCurses::A_BOLD
      end
      yield
      if condition
        FFI::NCurses.wattroff window, FFI::NCurses::A_BOLD
      end
    end
  end
end
