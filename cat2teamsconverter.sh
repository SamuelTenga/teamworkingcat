#!/usr/bin/bash

#init variables
msserver="https://suvaprodcloud.webhook.office.com/webhookb2/040a6947-3cd5-4e7e-9353-749d048e89cc@98616167-5668-4e66-acbf-925e81df8b00/IncomingWebhook/ea4e502406d246988ece15a1523c058c/dba68f66-ebf4-4010-88e1-14f34bc620ef"
apikey="x-api-key: live_QKo0wEgteUNBz92lqWL10sOyxttxGF7Q2GFighWR4N87SVuo3KibYvNR7U6o9zV6"

## Get The Cat
echo "Getting a new cat"
url=$( curl -H "x-api-key: live_QKo0wEgteUNBz92lqWL10sOyxttxGF7Q2GFighWR4N87SVuo3KibYvNR7U6o9zV6" -s 'https://api.thecatapi.com/v1/images/search?mime_types=jpg&size=med' | jq -r '.[0].url')

## Send The Cat
echo "Sending to MS Teams"
JSON="{ \"type\":\"message\", \"attachments\":[ { \"contentType\":\"application/vnd.microsoft.card.adaptive\", \"contentUrl\":null, \"content\":{ \"\$schema\": \"http://adaptivecards.io/schemas/adaptive-card.json\", \"type\": \"AdaptiveCard\", \"version\": \"1.3\", \"body\": [ { \"type\": \"Image\", \"url\": \"${url}\", \"altText\": \"CAT\" } ] }} ] }"
curl -H "Content-Type: application/json" -H "${apikey}"  -d "${JSON}" "${msserver}"

echo "Done."
