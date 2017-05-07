second="${1/\.*/}"
mkdir $second
#ffmpeg -i $1 -vf "select=eq(pict_type\,I)" -vsync vfr $second/frame%03d.jpg -hide_banner
ffmpeg -i $1 $second/frame%d.jpg

