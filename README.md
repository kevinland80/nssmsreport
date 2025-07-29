# nssmsreport
Generates a monthly bill report of SMS/MMS use by domain

This report uses sendgrid but can easily be modified for other email relays or postfix. 

ensure you make the script executable

chmod +x smsreport.sh

use a cronjob like 

0 0 1 * * root  /usr/local/scripts/smsreport.sh 0
