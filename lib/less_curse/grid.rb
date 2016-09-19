module LessCurse
  class Grid
    attr_accessor :widget_grid

    def initialize widget_grid=[[]]
      @widget_grid = widget_grid
    end

    def rows
      @widget_grid
    end

    def cols_in_row row_nr
      @widget_grid[row_nr].count
    end

    def widgets
      @widget_grid.flatten
    end

    def add widget
      @widget_grid.last << widget
    end
  end
end
