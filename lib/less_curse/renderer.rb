module LessCurse
  module Renderer
    def self.box_with_title window, title
      FFI::NCurses.box window, 0, 0
      FFI::NCurses.mvwaddstr window, 0, 1, title
    end
  end
end
