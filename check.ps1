# Splunk server details
$SplunkServer = "192.168.1.3"
$SplunkPort = "8089"
$SearchQuery = "*"
$TimeRange = "24h"

# Email details
$EmailFrom = "SplunkChecker@localhost"
$EmailTo = "SecurityOfficer@example.com"
$EmailSubject = "Splunk Log Count Alert"
$SMTPServer = "mail.example.com"
$SMTPPort = "587"
$SMTPUsername = "your_smtp_username"
$SMTPPassword = "your_smtp_password"

# Build the query
$uri = "https://${SplunkServer}:$SplunkPort/services/search/jobs/export"

$body = @{
    search = "search * earliest=-$TimeRange"
}

# Execute the query
[Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
$response=Invoke-RestMethod -Uri $uri -Method Post  -body $body

# Parse the response
$logCount = $response.results.result.count
"Log Count = " + $logCount

# Send email alert if log count is 0
if ($logCount -eq 0) {
    $EmailBody = "No log entries found in Splunk for the last 24 hours."
    $EmailBody
    "Sending email alert..."
    Send-MailMessage -From $EmailFrom -To $EmailTo -Subject $EmailSubject -Body $EmailBody -SmtpServer $SMTPServer -Port $SMTPPort -UseSsl -Credential (New-Object System.Management.Automation.PSCredential($SMTPUsername, (ConvertTo-SecureString $SMTPPassword -AsPlainText -Force)))
}