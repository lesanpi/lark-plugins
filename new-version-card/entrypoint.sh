#!/bin/sh
echo "👷🏻 Send message using BOT $APP_ID"
# Get access token
response=$(curl -s -X POST \
  https://open.larksuite.com/open-apis/auth/v3/app_access_token/internal \
  -H 'Content-Type: application/json; charset=utf-8' \
  -d "{
  \"app_id\": \"$APP_ID\",
  \"app_secret\": \"$APP_SECRET\"
}")

# Extract access token using jq
ACCESS_TOKEN=$(echo "$response" | jq -r '.app_access_token')
echo "✅ Access Token received"

# Generate UUID
uuid=$(openssl rand -hex 16)
uuid=${uuid:0:8}-${uuid:8:4}-${uuid:12:4}-${uuid:16:4}-${uuid:20:12}
echo "🔐 UUID Generated $uuid"
echo "💬 Send to type: $RECEIVE_ID_TYPE"
echo "📭 Receive ID: $RECEIVE_ID"

CONTENT='{\n  \"config\": {\n    \"wide_screen_mode\": true\n  },\n  \"elements\": [\n    {\n      \"tag\": \"markdown\",\n      \"content\": \"New version released. Review the release note [click here]('$LINK'), <at id=all></at>\"\n    }\n  ],\n  \"header\": {\n    \"template\": \"green\",\n    \"title\": {\n      \"content\": \"New Version Released '$VERSION'\",\n      \"tag\": \"plain_text\"\n    }\n  }\n}'
result=$(curl -s -X POST "https://open.larksuite.com/open-apis/im/v1/messages?receive_id_type=$RECEIVE_ID_TYPE" \
-H 'Content-Type: application/json' \
-H 'Authorization: Bearer '"$ACCESS_TOKEN"'' \
-d '{
  "content": "'"$CONTENT"'",
	"msg_type": "interactive",
	"receive_id": "'"$RECEIVE_ID"'",
	"uuid": "'"$uuid"'"
}')

# Check the exit code of the curl command
echo $result
if [ $? -eq 0 ]; then
  echo "✅ Success! Message sent."
else
  echo "❌ Failure! curl exited with code $?."
  echo "The response from curl was: $result"
fi
