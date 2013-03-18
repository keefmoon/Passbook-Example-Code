require 'net/smtp'

# This script accepts the following arguments: recipients name, recipients email address, path to Pass.
# Example usage: 
# ruby send_pass_by_email.rb "Peter Brooke" pbrooke@passkit.pro ../Pass-Example-Generic/Pass-Example-Generic.pkpass

# Retrieve command line arguments
recipientName = ARGV[0]
recipientEmail = ARGV[1]
passFilePath = ARGV[2]

# Setup template email values
senderName = "Passbook Example Company"
senderEmail = "info@passkit.pro" 
emailSubjectText = "New Employee Pass"
emailBodyText = "Please find attached your new employee Pass"

# Setup SMTP settings
smtpDomain = "TO DEFINE. Eg. gmail.com"
smtpLogin = "TO DEFINE. Eg. ......@gmail.com"
smtpPassword = "TO DEFINE" 

# Read file and base64 encode
fileContent = File.read(passFilePath)
encodedContent = [fileContent].pack("m")

# The is used to separate the MIME parts, it can be anything
# as long as it does not appear elsewhere in the email text
boundaryMarker = "SEPARATINGSTRINGNOTFOUNDELSEWHERE"

# Setup the email headers.
headers =<<EOF
From: #{senderName} <#{senderEmail}>
To: #{recipientName} <#{recipientEmail}>
Subject: #{emailSubjectText}
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=#{boundaryMarker}
--#{boundaryMarker}
EOF

# Setup the email body
body =<<EOF
Content-Type: text/plain
Content-Transfer-Encoding:8bit

#{emailBodyText}
--#{boundaryMarker}
EOF

# Setup the Pass attachment with the correct MIME Encoding
attachment =<<EOF
Content-Type: application/vnd.apple.pkpass; name=\"#{passFilePath}\"
Content-Transfer-Encoding:base64
Content-Disposition: attachment; filename="#{passFilePath}"

#{encodedContent}
--#{boundaryMarker}--
EOF

completeEmail = headers + body + attachment

# Send email using your SMTP settings
smtp = Net::SMTP.new 'smtp.gmail.com', 587
smtp.enable_starttls
smtp.start(smtpDomain, smtpLogin, smtpPassword, :login) do
	smtp.send_message(completeEmail, senderEmail, recipientEmail)
end