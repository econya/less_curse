#!/usr/bin/env ruby
# Released under the GPLv3+, Copyright 2016 Felix Wolfsteller

require 'less_curse'

LessCurse.log_to! $PROGRAM_NAME + ".log"

def list_ui
  simple_list = [1, 2, 3, 4, 5, 6, 7]

  list_ui = LessCurse::Widgets::List.new
  list_ui.data = simple_list
  list_ui.on_select = LessCurse::Actions::QUIT
  list_ui
end

def hash_ui
  simple_hash = {rainbows: "fabolous",
                 unicorns: "magnificient",
                 sunrise:  "fantastic",
                 sunset:   "marvellous"}
  LessCurse::Widgets::List.new data: simple_hash, title: "Hash keys"
end

def textview_ui
  LessCurse::Widgets::TextView.new title: 'TextView',
                                   data: "Showing Text Data\nSecond Line of Text Data"
end

begin
  grid = LessCurse::Grid.new [[list_ui, hash_ui],
                              [textview_ui]]
  # Set grid
  LessCurse.screen.add grid

  # Display it, really
  LessCurse.show_screen

  # Deal with keyboard input and keep us living
  LessCurse.enter_loop!

  # Try to debug
  LessCurse.screen.windows.each do |widget, window|
    puts "#{widget} -> #{window}"
  end
ensure
  LessCurse.close_screen
end

