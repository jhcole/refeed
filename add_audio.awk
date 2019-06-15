#! /usr/bin/awk

{	print $0 }

/<link>.*post/ {
	post_url = gensub(/.*<link>(.*)<\/link>.*/, "\\1", 1);
	audio_url = ""
	command = "wget " post_url " -q -O - | awk -f get_audio_url.awk"
	command | getline audio_url
	close(command)
	if (audio_url != "") {
		# make local copy of audio file to avoid 502 errors in podcast app
		opath = "data/" gensub(/https?:\/\//, "", 1, audio_url)
		obase = gensub(/(.*)\/.*mp3/, "\\1", 1, opath)
		command = "mkdir -p " obase " && wget " audio_url " -q -O " opath
		system(command)
		print "<enclosure url=\"" opath "\" type=\"audio/mpeg\"/>"
	}
}
