ffprobe -show_frames $1 | grep pict_type > output.txt
second="${1/\.*/}"
gop=1;
while read p; do
    if [ "$p" = "pict_type=I" ]
    then
        echo $gop
        name="frame$gop.jpg"
        temp=
        newname="frame${gop}I.jpg"
        mv $second/$name $second/$newname
    fi
    gop=$((gop+1))
done < output.txt
rm output.txt


