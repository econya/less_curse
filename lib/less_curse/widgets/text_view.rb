module LessCurse
  module Widgets
    class TextView < Base
      def refresh
        window = LessCurse.screen.windows[self]
        LessCurse::Renderer::box_with_title window, @title
        FFI::NCurses.wmove window, 1, 1
        FFI::NCurses.waddstr window, @data.to_s
      end
    end
  end
end
