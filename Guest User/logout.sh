#!/bin/bash
userCheck=True
while [[ $userCheck == True ]]
do
	guestLine=$(grep -E "^(guest-.*):x:(.*)$" /etc/passwd)
	guestUser=${guestLine:0:12}
	if [[ ! -z $guestUser ]]
	then
		/usr/sbin/userdel -f $guestUser
	else
		userCheck=False
	fi
done
