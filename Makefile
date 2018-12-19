unpack:
	java -jar abe-all.jar unpack gks_original.ab backup.tar
	tar tf backup.tar | grep -F "com.turbochilli.gks" > package.list
	tar xvf backup.tar
	rm backup.tar
	perl -lne '/inventory_db">(.*)</ && print "$$1"' apps/com.turbochilli.gks/sp/com.turbochilli.gks.v2.playerprefs.xml > inventory_db.txt

pack:
	tar cf restore.tar -T package.list
	java -jar abe-all.jar pack restore.tar gks_modded.ab
	rm inventory_db.txt
	rm package.list
	rm -rf apps
	rm restore.tar

backup:
	adb backup -f gks_original.ab com.turbochilli.gks

restore:
	adb restore gks_modded.ab
