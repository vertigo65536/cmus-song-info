#!/bin/bash
#$(cmus-remote -q ~/song52.mp3)
#$(cmus-remote -p) 
while [ 1 = 1 ]
do
	#uncomment to refresh in line
	#echo -ne "\r\033[K"
	RUNNING="$(cmus-remote -C status)"
	OUTPUT=""
	if [ "$RUNNING" == '' ]
	then
		 printf " "
	else
		TOTAL="$(cmus-remote -Q | grep 'duration ' | sed -r 's/^.{8}//')"
		if [ "$TOTAL" == '' ]
		then
			printf "No song selected"
		else	
			TOTAL="$(cmus-remote -Q | grep 'duration ' | sed -r 's/^.{8}//')"
			SECONDS="$(cmus-remote -Q | grep 'position ' | sed -r 's/^.{8}//')"
			STATUS="$(cmus-remote -Q | grep status | sed -r 's/^.{7}//')"
			TITLE="$(cmus-remote -Q | grep title | sed -r 's/^.{10}//')"
			ARTIST="$(cmus-remote -Q | grep ' artist ' | sed -r 's/^.{11}//')"
			ALBUM="$(cmus-remote -Q | grep ' album ' | sed -r 's/^.{10}//')"
			FILE="$(cmus-remote -Q | grep 'file ' | sed -r 's/^.{5}//')"
			if [ "$STATUS" == "playing" ]
			then
				OUTPUT=$OUTPUT" "
			elif [ "$STATUS" == "paused" ]
			then
				OUTPUT=$OUTPUT" "
			elif [ "$STATUS" == "stopped" ]
			then
				OUTPUT=$OUTPUT" "
			else
				OUTPUT=$OUTPUT"$STATUS"
			fi
			if [ "$TITLE" == "" ] && [ "$ARTIST" == "" ] && [ "$ALBUM" == "" ]
			then
				OUTPUT=$OUTPUT"$FILE"	
			elif [ "$TITLE" == "" ]
			then
				OUTPUT=$OUTPUT"$FILE"" - ""$ARTIST"" - ""$ALBUM"
			else
				OUTPUT=$OUTPUT"$TITLE"" - ""$ARTIST"" - ""$ALBUM"
			fi
			OUTPUT=$OUTPUT" | "
			OUTPUT=${OUTPUT/"&"/"&amp;"}	
			printf "%s%02d:%02d/%02d:%02d   " "$OUTPUT" $(($SECONDS/60)) $(($SECONDS%60)) $(($TOTAL/60)) $(($TOTAL%60))
		fi		
	fi
	sleep 1
done
