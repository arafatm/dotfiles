notify-send -i mail 'GMailing' `echo $1 | sed 's/mailto://'`
/usr/bin/sensible-browser -remote "openurl(https://mail.google.com/mail?view=cm&tf=0&to=`echo $1 | sed ’s/mailto://’`,new-tab)"
