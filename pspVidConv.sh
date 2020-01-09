echo "Gib Output FileName"
read outName
ep=1
mkdir "$outName"-PSPReady
mkdir tmp
for i in *.mkv
do
  ffmpeg  -i "$i" tmp/"$outName"_`printf "%02d" $ep`-PSPReady.ass
  ffmpeg -y -i "$i" -flags +bitexact -vcodec libx264 -profile:v baseline -level 3.0 -s 480x272 -b:v 1m -acodec aac -b:a 128k -ar 48000 -strict -2 -filter:v subtitles=tmp/"$outName"_`printf "%02d" $ep`-PSPReady.ass:force_style='Fontsize=46' "$outName"-PSPReady/"$outName"_`printf "%02d" $ep`-PSPReady.MP4
  ffmpeg -i "$i" -f image2 -ss 5 -vframes 1 -s 160x120  "$outName"-PSPReady/"$outName"_`printf "%02d" $ep`-PSPReady.THM
  ((ep ++))
done

rm -rf tmp
