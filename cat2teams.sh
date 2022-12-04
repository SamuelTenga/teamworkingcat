################ INIT #####################
echo "DOWNLOADING CAT"
#Get a new cat from api
url=$( curl -H "x-api-key: live_QKo0wEgteUNBz92lqWL10sOyxttxGF7Q2GFighWR4N87SVuo3KibYvNR7U6o9zV6" -s 'https://api.thecatapi.com/v1/images/search?mime_types=jpg&size=small' | jq -r '.[0].url')
#Download cat
wget "${url}" -q
#Save filename for later
name=$(basename ${url})

########## Sending to Teams ###############
echo "SENDING SENDING TO TEAMS"
#Change to real server here
MS_SERVER="https://webhook.site/bbc533a8-9e1f-43b5-a2a3-39264c0ea0e2"
#JSON Body preformationg and base 64 encoding image
JSON=" { \"@type\": \"MessageCard\", \"text\": \"Cat of the Day\", \"sections\": [ { \"images\": [ { \"image\": \"data:image/jpg;base64,$(cat ${name} | base64 | tr -d '\r\n')\" } ] } ]} }"
# Post to Microsoft Teams.
curl -H "Content-Type: application/json" -H "x-api-key: live_QKo0wEgteUNBz92lqWL10sOyxttxGF7Q2GFighWR4N87SVuo3KibYvNR7U6o9zV6"  -d "${JSON}" "${MS_SERVER}" 
echo "COMPLETED IN ${SECONDS}s"
echo $SECONDS
