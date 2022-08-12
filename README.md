# bluray-audio-extract
This is a record, of how to extract bluray audio with ffmepg.

## Requirements

* ffmepg

## Prepare

Use `ffprobe` you should get the chapter info. you can directly go to [Method 1](#method-1).

```
user $ffprobe ...
...
Chapter #0.2: start 534.934400, end 888.087200
```

If same thing wrong like me, `ffprobe` parse playlist failed, than go to [Method 2](#method-2).

```
user $ffprobe ...
...
bluray.c:299: 00000.m2ts: no timestamp for SPN 0 (got 0). clip 188955000-779528733.
```

## Method 1

1. Copy chapters outputs to a file, like [example-track.log](example-track.log).
2. Execute [track.sh](track.sh), will get ffmpeg command line.
3. following ffmpeg you will get audo files.

## Method 2

Need [bdinfo](https://github.com/schnusch/bdinfo) help generate chapters.

```
user $bdinfo /dev/sr0 -p 0 -c -f jpn -L

ffmpeg -playlist 0 -i bluray:/dev/sr0 -i - -map 0:i:0x1011 -map 0:i:0x1100 -map 0:i:0x1400 -c copy -c:1 flac -compression_level 12 -metadata:s:1 'language=jpn' -metadata:s:2 'language=jpn' -map_chapters 1 jpn << EOF
;FFMETADATA1
[CHAPTER]
TIMEBASE=1/90000
START=0
...
```

And use `bdinfo` outputs(ffmepg command), you will get chapters info, save to a file, then go back to [Method 1](#method-1).

## Reference
* [FFmpeg - Extract Blu-Ray Audio](https://wiki.gentoo.org/wiki/FFmpeg_-_Extract_Blu-Ray_Audio)
* [bdinfo](https://github.com/schnusch/bdinfo), a [backup](https://github.com/abriko/bdinfo)