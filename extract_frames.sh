#ffprobe -show_frames $1 | grep pict_type > output.txt

#gop=1;

#while read p; do
    #if [ "$p" = "pict_type=I" ]
    #then
        #echo $gop
    #fi
    #gop=$((gop+1))
#done < output.txt

#rm output.txt

second="${1/\.*/}"
mkdir $second
ffmpeg -i $1 -vf "select=eq(pict_type\,I)" -vsync vfr $second/frame%03d.jpg -hide_banner

