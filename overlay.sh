#!/bin/sh

set -e
set -u

INSTANCE=$1
DATA=input/$INSTANCE-data.csv
INPDF=input/$INSTANCE-final
OUTPDF=output/$INSTANCE-final
OVPDF=overlays/

for ID in `tail -n +2 $DATA | cut -d ',' -f1`
do
    BADGES=`grep "^$ID," $DATA | sed -E 's/.*"Badges: (.*)",.*/\1/g'`
    IN=$INPDF$ID.pdf
    OUT=$OUTPDF$ID-badges.pdf
    OVERLAY=$OVPDF$BADGES.pdf

    if [ ! -f $IN ] 
    then
        echo " * [$ID] Warning: skipping nonexistent file $IN"
        continue
    fi
    NUMPAGES=`pdftk $IN dump_data 2>&1 | grep NumberOfPages | cut -d ' ' -f2`

    echo " * [$ID] Processing $IN --> $OUT (pp=$NUMPAGES)"
    if [ $NUMPAGES -eq 1 ]
    then
        pdftk "$IN" stamp "$OVERLAY" output "$OUT"
        continue
    fi
    pdftk "$IN" cat 1 output "$IN.front"
    pdftk "$IN" cat 2-end output "$IN.rest"
    pdftk "$IN.front" stamp "$OVERLAY" output "$OUT.front"
    pdftk "$OUT.front" "$IN.rest" cat output "$OUT"
    rm -f $IN.front $IN.rest $OUT.front
done
