#!/bin/bash

# Create service
echo 'Creating Service';
SERVICE="
[Unit]
Description=Download Youtube Playlist
 
[Service]
Type=oneshot
User=$USER
ExecStart=$(pwd)/list.sh
";
sudo su -c "echo '$SERVICE' > /etc/systemd/system/youtube-playlist-downloader.service";
sudo su -c "chmod +x /etc/systemd/system/youtube-playlist-downloader.service"

# Create timer
echo 'Creating Timer';
TIMER="
[Unit]
Description=Download Youtube Playlist

[Timer]
OnBootSec=15min
OnUnitActiveSec=1h
Unit=youtube-playlist-downloader.service

[Install]
WantedBy=default.target
";
sudo su -c "echo '$TIMER' > /etc/systemd/system/youtube-playlist-downloader.timer";
sudo su -c "chmod +x /etc/systemd/system/youtube-playlist-downloader.timer"

echo 'Done';
