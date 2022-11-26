require_relative 'interactive_init'

clear_screen

lines = ENV.fetch('LINES', console_rows + 1).to_i

puts <<~TEXT

Console Buffer
= = =
#{console_info}
Lines: #{lines}#{' (default, set via e.g. LINES=11)' if not ENV.key?('LINES')}

TEXT

buffer = Output::Writer::Buffer::Console.build
buffer.receive(<<TEXT)
\e[1mBuffering\e[22m
TEXT

(0...lines).each do |index|
  buffer.receive(<<-TEXT)
  Line ##{index + 1}
  TEXT
end

sleep 1

buffer.flush

puts "\e[1mFinished buffering\e[22m"

(0..lines).each do |index|
  puts(<<-TEXT)
  Line ##{index + 1}\e[0K
  TEXT
end

puts <<~TEXT
(done)
- - -

TEXT
