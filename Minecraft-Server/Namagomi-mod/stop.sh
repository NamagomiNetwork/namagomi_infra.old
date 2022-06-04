#!/bin/sh

screen -S mc -X stuff "save-all\015"
sleep 10
screen -S mc -X stuff "say まもなく再起動されます\015"
sleep 10
screen -S mc -X stuff "stop\015"