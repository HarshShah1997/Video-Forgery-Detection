second="${1/\./_mpg.}"
ffmpeg -i $1 -c:v mpeg2video $second
