#! /bin/bash

while read name url; do
	# retrieve the feed
	wget $url -q -O "feeds/$name"

	# these feeds don't include audio files so we have to add them
	awk -f add_audio.awk "feeds/$name" > "feeds/${name}_enhanced"
done < podcasts.txt
