# raspi-midi-usb-hub

Custom setup; original post is here: https://neuma.studio/raspberry-pi-as-usb-bluetooth-midi-host/

Using an old Raspberry Pi Model B

## Preparations

1. download https://downloads.raspberrypi.com/raspios_lite_armhf/images/raspios_lite_armhf-2024-03-13/2024-03-12-raspios-bookworm-armhf-lite.img.xz

2. unxz the file: `unxz 2024-03-12-raspios-bookworm-armhf-lite.img.xz`

3. write it to SD card: `sudo dd if=~/Downloads/2024-03-12-raspios-bookworm-armhf-lite.img of=/dev/mmcblk0 bs=1024k status=progress`

  - extend filesystem: Disks > Edit > Resize 'rootfs' partition
  - eject and reinsert SD card

4. create wpa_supplicant.conf and connect via SSH (find raspi's ip with nmap)

```bash
# create wifi network file with the following information
echo '
country=us
update_config=1
ctrl_interface=/var/run/wpa_supplicant

network={
    ssid="YOUR_NETWORK_NAME"
    psk="YOUR_PASSWORD"
    scan_ssid=1
    key_mgmt=WPA-PSK
}
' > /media/lorenz/bootfs/wpa_supplicant.conf

# to enable ssh add file ssh in boot partition
touch /media/lorenz/bootfs/ssh
```

5. install everything: log via ssh into raspberry and execute the following commands

```bash
git clone https://github.com/kapsner/raspi-midi-usb-hub
cd raspi-midi-usb-hub
./install.sh
```

To manually update all MIDI-devices, run `./update.sh`
