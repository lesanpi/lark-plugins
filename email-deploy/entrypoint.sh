now=$(date +'%Y-%m-%d %H:%M:%S')
data='{
  "app_name": "'$APP_NAME'",
  "version": "'$VERSION'",
  "date": "'$now'",
  "links": [
    { "url": "'$LINK'" }
  ]
}'
postmark email template -f=noreply@avilatek.com -t=$RECEIVE_EMAIL -a=deploy-new -m="$data"