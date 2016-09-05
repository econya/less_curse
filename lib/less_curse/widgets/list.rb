module LessCurse
  module Widgets
    class List < Base
      attr_accessor :on_select
      attr_accessor :selected_data
      attr_accessor :actions
      attr_accessor :top_element_idx

      @top_element_idx = 0

      def refresh
        window = LessCurse.screen.windows[self]
        FFI::NCurses.wclear window

        LessCurse::Renderer::box_with_title window, @title

        # Do we have kind of a display-window?
        visible_data.each_with_index do |d, idx|
          if selected_data == d
            FFI::NCurses.wattron window, FFI::NCurses::A_BOLD
          end

          write_line_at window, idx, d.to_s

          if selected_data == d
            FFI::NCurses.wattroff window, FFI::NCurses::A_BOLD
          end
        end

        if visible_data.size != @data.size
          LessCurse::Renderer::box_foot window, "..."
        end
      end

      def handle_input key
        # return false if action = @actions[key]
        case key
        when FFI::NCurses::KEY_UP
          select_previous
        when FFI::NCurses::KEY_DOWN
          select_next
        else
          return false
        end
      end

      # Select previous data element in list (roll over if nexessary)
      def select_previous
        if @selected_data.nil? && @data.size >= 0
          @selected_data = @data.to_a[0]
        else
          @selected_data = @data.to_a[(selected_data_index - 1) % @data.size]
        end
        recalc_top_index
        if @on_select
          @on_select.call @selected_data
        end
      end

      # Select next data element in list (roll over if nexessary)
      def select_next
        if @selected_data.nil? && @data.size >= 0
          @selected_data = @data.to_a[0]
        else
          @selected_data = @data.to_a[(selected_data_index + 1) % @data.size]
        end
        recalc_top_index
        if @on_select
          @on_select.call @selected_data
        end
      end

      private

      # Get index of given element in @data
      def data_index element
        @data.to_a.index(element)
      end

      # Get index of selected element in @data
      def selected_data_index
        data_index @selected_data
      end

      def recalc_top_index
        window = LessCurse.screen.windows[self]
        height,width = FFI::NCurses::getmaxyx(window)
        if @data.size <= (height - 2)
          @top_element_idx = 0
        else
          @top_element_idx = [selected_data_index, (@data.size - (height - 2)).abs].min
        end
      end

      def visible_data
        @top_element_idx ||= 0
        window = LessCurse.screen.windows[self]
        height,width = FFI::NCurses::getmaxyx(window)
        # -2: border, -1: 0-based indexing
        @data.to_a[@top_element_idx..(@top_element_idx + height - 2 - 1)]
      end

      # Write a line in window
      def write_line_at window, line, text
        FFI::NCurses.mvwaddstr window, line + 1, 1, text
      end
    end
  end
end
