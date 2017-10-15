## Simple youtube playlist downloader

#### Usage
`./download [playlistId] [video|audio]`

#### Instalation (Systemd timer)

  1. Add playlist to download in `list.sh`
  1. Run `./install.sh`
  2. Enable systemd timer `sudo systemctl enable youtube-playlist-downloader.timer`
