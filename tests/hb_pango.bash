#!/bin/bash

rm -fr hb_pango
mkdir -p hb_pango
mkdir -p hb_pango/pango
mkdir -p hb_pango/hb

touch hb_pango/index.html
echo '<!DOCTYPE html>' >> hb_pango/index.html
echo "<html><head><title>Harfbuzz and Pango rendering test</title>" >> hb_pango/index.html
echo "<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'></head><body>" >> hb_pango/index.html

number=1
# read characters in inputfile
while read ALINE
do
    hb-view ~/.fonts/Gubbi.ttf "$ALINE" --font-size=30 --output-file=hb_pango/hb/$number.png
    pango-view -q --font="Gubbi 20" --text="$ALINE" --output=hb_pango/pango/$number.png

    echo "<p style='font-size:20px;border-bottom:1px solid #aaa;margin-bottom:10px;'><strong style='font-size:12px;color:#555'>TEXT : </strong>$ALINE <br/>" >> hb_pango/index.html
    echo "<strong style='font-size:12px;color:#555'>HB   : </strong><br/><img src='hb/"$number".png'/><br/>" >> hb_pango/index.html
    echo "<strong style='font-size:12px;color:#555'>PANGO: </strong><br/><img src='pango/"$number".png'/></p><br/><br/>" >> hb_pango/index.html

    number=$((number + 1))
done < test_cases.txt

echo "</body></html>" >> hb_pango/index.html
