#!/bin/bash

start=""
end=""
i=1

while read line; do
    start=${line#*start }
    start=${start%,*}
    end=${line#*end }

    #echo "ffmpeg -playlist 0 -i bluray:/dev/sr0 -map 0:i:0x1100 -ss $start -to $end -acodec pcm_s24le $i.wav"
    echo "ffmpeg -playlist 0 -i bluray:/dev/sr0 -map 0:i:0x1100 -ss $start -to $end -acodec flac -compression_level 12 $i.flac"

    # cleanup
    start=""
    end=""
    ((i++))
done < ./example-track.log
