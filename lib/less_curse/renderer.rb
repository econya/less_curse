module LessCurse
  module Renderer
    def self.box_with_title window, title
      FFI::NCurses.box window, 0, 0
      FFI::NCurses.mvwaddstr window, 0, 1, title
    end
    def self.box_foot window, text
      height,width = FFI::NCurses::getmaxyx(window)
      FFI::NCurses.mvwaddstr window, height - 1, 1, text
    end
  end
end
