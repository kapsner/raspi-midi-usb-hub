#!/bin/bash

sudo apt-get update
sudo apt-get install -y byobu git ruby wget

sudo wget -O /usr/local/bin/connectall.rb https://gist.githubusercontent.com/chmanie/4f2838f4548d25b9c883f7d6d074f67c/raw/5d73927cf8f8bc1055963559aa44e7faa00926ed/connectall.rb
sudo chmod +x /usr/local/bin/connectall.rb

cat << EOF | sudo tee /etc/udev/rules.d/33-midiusb.rules
ACTION=="add|remove", SUBSYSTEM=="usb", DRIVER=="usb", RUN+="/usr/local/bin/connectall.rb"  
EOF

sudo udevadm control --reload
sudo service udev restart

cat << EOF | sudo tee /lib/systemd/system/midi.service
[Unit]
Description=Initial USB MIDI connect

[Service]
ExecStart=/usr/local/bin/connectall.rb

[Install]
WantedBy=multi-user.target

EOF

sudo systemctl daemon-reload
sudo systemctl enable midi.service
sudo systemctl start midi.service

aconnect -l
