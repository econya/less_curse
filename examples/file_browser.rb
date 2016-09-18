#!/usr/bin/env ruby
# Released under the GPLv3+, Copyright 2016 Felix Wolfsteller

require 'less_curse'

viewer = LessCurse::Widgets::TextView.new title: 'File Content',
                                          data:  'Use TAB to change focus'\
                                                 'UP/DOWN to select file'

file_list_ui = LessCurse::Widgets::List.new title: 'Files:',
                                            data:  Dir['*']
file_list_ui.on_select = lambda do |selected_file|
  viewer.title = selected_file
  if File.file? selected_file
    viewer.data = File.new(selected_file).readlines
  else
    viewer.data = "[Probably a directory]"
  end
end

begin
  # Display file list
  LessCurse.screen.add file_list_ui

  # Display file content (once file selected)
  LessCurse.screen.add viewer

  # Show off with header and footer
  LessCurse.screen.header = "-- ** filebrowser ** --"
  LessCurse.screen.footer = "[CTRL_Q to quit]"

  # Display it, really
  LessCurse.show_screen

  # Deal with keyboard input and keep us living
  LessCurse.enter_loop!
ensure
  LessCurse.close_screen
end
