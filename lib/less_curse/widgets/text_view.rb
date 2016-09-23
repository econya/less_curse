module LessCurse
  module Widgets
    class TextView < Base
      def draw window
        LessCurse::Renderer::bold_if(focused?, window) do
          LessCurse::Renderer::box_with_title window, @title
        end
        FFI::NCurses.wmove window, 1, 1
        @data.to_s.split("\n").each_with_index do |line, idx|
          FFI::NCurses.mvwaddstr window, idx + 1, 1, line
        end
      end
    end
  end
end
