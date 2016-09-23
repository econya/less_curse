#!/usr/bin/env ruby
# Released under the GPLv3+, Copyright 2016 Felix Wolfsteller

require 'less_curse'

LessCurse.log_to! $PROGRAM_NAME + ".log"

begin
  # Initialize Widgets
  list_ui = LessCurse::Widgets::List.new
  list_ui.data = [1, 2, 3, 4, 5, 6, 7]

  button = LessCurse::Widgets::Button.new title: "Square that number in a popup"
  button.on_press = lambda do |b|
    selection_square = list_ui.selected_data * list_ui.selected_data
    LessCurse.screen.show_popup :info, "#{selection_square}!"
  end

  # Display list items
  LessCurse.screen.add list_ui

  # Display button
  LessCurse.screen.add button

  # Display it, really
  LessCurse.show_screen

  # Deal with keyboard input and keep us living
  LessCurse.enter_loop!
ensure
  LessCurse.close_screen
end
