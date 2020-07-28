#!/bin/bash
echo
echo " ____                                               "
echo "|____ \                          /\                 "
echo "     \ \   ____  ____    ___    /  \   ____   ____  "
echo "| |   | | / _  )|    \  / _ \  / /\ \ |  _ \ |  _ \ "
echo "| |__/ / ( (/ / | | | || |_| || |__| || | | || | | |"
echo "|_____/   \____)|_|_|_| \___/ |______|| ||_/ | ||_/ "
echo "                                      |_|    |_|    "
echo 

echo
echo "👋🏻 Hello "$USER"!"
echo "📺 Let's create a ROKU build!"
echo

echo -n "IP TO DEPLOY (Roku target) :"
echo
echo "Default is "$ROKU_DEV_TARGET""
echo "- Type your own (Format: IP)"
read IP
echo

echo -n "ROKU PASSWORD TO DEPLOY :"
echo
echo "Default is "$DEVPASSWORD""
echo "- Other (type your own)."
read ROKU_PASS
echo

if [[ "$IP" == "" ]]; then
IP=$ROKU_DEV_TARGET
fi

if [[ "$ROKU_PASS" == "" ]]; then
ROKU_PASS=$DEVPASSWORD
fi


echo "> LAUNCHING DemoApp! 👩🏻‍💻"
echo "> DEPLOYING TO: $IP"

echo
echo "------------------"
echo "Build command is :"
echo "export ROKU_DEV_TARGET=$IP && export DEVPASSWORD=$ROKU_PASS && make install && cd .. && nc $IP 8085"
echo "------------------"
echo

echo
echo " ____                                               "
echo "|____ \                          /\                 "
echo "     \ \   ____  ____    ___    /  \   ____   ____  "
echo "| |   | | / _  )|    \  / _ \  / /\ \ |  _ \ |  _ \ "
echo "| |__/ / ( (/ / | | | || |_| || |__| || | | || | | |"
echo "|_____/   \____)|_|_|_| \___/ |______|| ||_/ | ||_/ "
echo "                                      |_|    |_|    "
echo 
echo
echo

export ROKU_DEV_TARGET=$IP && export DEVPASSWORD=$ROKU_PASS && make install  && telnet $IP 8085

nc $IP 8085