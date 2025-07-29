#!/bin/bash

    # Database credentials
    DB_USER="username"
    DB_PASSWORD="password"
    DB_NAME="MessagingDomain"

    # Email details
    EMAIL_RECEIVER="user@domain.com"
    EMAIL_SUBJECT="NetSapiens SMS Use Report"
    SENDGRID_KEY="SGKEY"

    # MySQL Query
    QUERY="select domain, count(*) msgcount from message where EXTRACT(YEAR_MONTH FROM timestamp) = EXTRACT(YEAR_MONTH FROM CURDATE() - INTERVAL 1 MONTH) and (type='mms' or type='sms') GROUP BY DOMAIN ORDER BY DOMAIN;"

    # Execute query and store results
    QUERY_RESULT=$(mysql -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" -H -e "$QUERY")

    # Send email with results
    curl -X POST "https://api.sendgrid.com/v3/mail/send"  --header "Content-Type: application/json"  --header "authorization: BEARER $SENDGRID_KEY"  --data "{ \"personalizations\": [{\"to\": [{\"email\": \"${EMAIL_RECEIVER}\", \"name\": \"SMS NAME\"}]}], \"from\": {\"email\": \"noreply@connectstack.com\", \"name\": \"ConnectWare\"}, \"subject\": \"${EMAIL_SUBJECT}\", \"content\": [{\"type\": \"text/html\", \"value\":\"${QUERY_RESULT}\"}] }"
