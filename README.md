# Splunk Checker
This is a powershell script that periodically checks Splunk for CMMC / NIST SP 800-171 3.3.4 purposes

NIST SP 800-171 3.3.4 is "Alert in the event of an audit logging process failure"

You can run this script from windows task scheduler daily and it will query your Splunk server for a message count for the past 24 hours.  If the server responds with 0, responds with an error, or doesn't respond at all, the script will send an email alert.

To make the free version of splunk work
1. nano /opt/splunk/etc/system/local/server.conf
2. under [general] add:
	allowRemoteLogin=always
3. systemctl restart splunk
