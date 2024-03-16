#!/usr/bin/ruby
# source https://gist.github.com/chmanie/4f2838f4548d25b9c883f7d6d074f67c?ref=neuma.studio
# https://gist.githubusercontent.com/chmanie/4f2838f4548d25b9c883f7d6d074f67c/raw/5d73927cf8f8bc1055963559aa44e7faa00926ed/connectall.rb

# unconnect everything
system "aconnect -x"

t = `aconnect -i -l`
ports = []
names = []
t.lines.each do |l|
  /client (\d*)\: '(.*)'/=~l
  port = $1
  name = $2
  # we skip empty lines and the "Through" port
  unless $1.nil? || $1 == '0' || /Through/=~l
    ports << port
    names << name
  end
end

ports.each do |p1|
  ports.each do |p2|
    unless p1 == p2 # probably not a good idea to connect a port to itself
      system  "aconnect #{p1}:0 #{p2}:0"
    end
  end
end
