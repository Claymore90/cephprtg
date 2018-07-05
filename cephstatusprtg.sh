#!/bin/bash
#This script is provided under the MIT License
#
#Copyright (c) [2018] [Sven Rath]
#
#Contact
#E-Mail: sven.rath@mail.de
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.
#
#
# What this sript does:
#   Simple bash script to execute ceph -s command and filter it for the 3 important states OK, WARNING and ERROR.
#   Output into PRTG format to integrate into your PRTG monitoring (ssh custom script) put into /var/prtg/scripts


#reset variables just in case
result=0
alarm=0
information=0

result=`sudo /usr/bin/ceph -s | grep health | awk '{print $2}'`
information=`sudo /usr/bin/ceph -s | grep -A1 health | grep -v health`

        if [[ $result = HEALTH_OK ]]
        then
                alarm=0:0:"HEALTH_OK"

        fi
        if [[ $result = HEALTH_WARN ]]
        then
                alarm=1:1:"HEALTH_WARN $information"

        fi
        if [[ $result = HEALTH_ERR ]]
        then
                alarm=2:2:"HEALTH_ERR $information"

        fi


echo $alarm
exit 1
