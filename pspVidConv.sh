echo "Gib Output FileName"
read outName
ep=`printf "%02d" 1`
mkdir "$outName"-PSPReady
mkdir tmp
for i in *.mkv
do
  ffmpeg  -i "$i" tmp/"$outName"_"$ep"-PSPReady.ass
  ffmpeg -y -i "$i" -flags +bitexact -vcodec libx264 -profile:v baseline -level 3.0 -s 480x272 -b:v 1m -acodec aac -b:a 128k -ar 48000 -strict -2 -filter:v subtitles=tmp/"$outName"_"$ep"-PSPReady.ass:force_style='Fontsize=46' "$outName"-PSPReady/"$outName"_"$ep"-PSPReady.MP4
  ffmpeg -i "$i" -f image2 -ss 5 -vframes 1 -s 160x120  "$outName"-PSPReady/"$outName"_"$ep"-PSPReady.THM
  ((ep ++))
  ep=`printf "%02d" $ep`
done

rm -rf tmp
