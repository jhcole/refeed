/mp3/ {
	print gensub(/.*href="(.+\.mp3)".*/, "\\1", 1, $0);
}
