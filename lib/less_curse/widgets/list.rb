module LessCurse
  module Widgets
    class List < Base
      attr_accessor :on_select
      attr_accessor :selected_data
      attr_accessor :top_element_idx

      @top_element_idx = 0

      def set_default_actions
        @actions = { FFI::NCurses::KEY_UP   => :select_previous,
                     FFI::NCurses::KEY_DOWN => :select_next}
      end

      def refresh
        window = LessCurse.screen.windows[self]
        FFI::NCurses.wclear window

        LessCurse::Renderer::bold_if focused?, window do
          LessCurse::Renderer::box_with_title window, @title
        end

        # Do we have kind of a display-window?
        visible_data.each_with_index do |d, idx|
          LessCurse::Renderer::bold_if(@selected_data == d, window) do
            LessCurse::Renderer::write_line window, idx, d.to_s
          end
        end

        if visible_data.size != @data.size
          LessCurse::Renderer::box_foot window, "..."
        end
      end

      def handle_input key
        action = @actions[key]
        LessCurse::debug_msg "List will execute action: #{action}"
        return false if !action
        send(action)
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
        @selected_data
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
        @selected_data
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
    end
  end
end
