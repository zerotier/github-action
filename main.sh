set -euo pipefail
IFS=$'\n\t'

echo "⏁  Installing ZeroTier"
# /home/runner/work/zerotier-github-action/zerotier-github-action/./
echo $GITHUB_ACTION_PATH

case $(uname -s) in
MINGW64_NT?*)
  pwsh "$GITHUB_ACTION_PATH/util/install.ps1"
  ztcli="/c/Program Files (x86)/ZeroTier/One/zerotier-cli.bat"
  member_id=$("${ztcli}" info | awk '{ print $3 }')
  ;;
*)
  . $GITHUB_ACTION_PATH/util/install.sh &>/dev/null
  member_id=$(sudo zerotier-cli info | awk '{ print $3 }')
  ;;
esac

echo "⏁  Authorizing Runner to ZeroTier network"
MAX_RETRIES=10
RETRY_COUNT=0

while ! curl -s -X POST \
  -H "Authorization: token $AUTH_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"name":"Zerotier GitHub Member '"${GITHUB_SHA::7}"'", "description": "Member created by '"${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}"'", "config":{"authorized":true}}' \
  "$API_URL/network/$NETWORK_ID/member/${member_id}" | grep '"authorized":true'; do
  RETRY_COUNT=$((RETRY_COUNT + 1))

  if [ $RETRY_COUNT -ge $MAX_RETRIES ]; then
    echo "Reached maximum number of retries ($MAX_RETRIES). Exiting..."
    exit 1
  fi

  echo "Authorization failed. Retrying in 2 seconds... (Attempt $RETRY_COUNT of $MAX_RETRIES)"
  sleep 2
done

echo "Member authorized successfully."
echo "⏁  Joining ZeroTier Network ID: $NETWORK_ID"
case $(uname -s) in
MINGW64_NT?*)
  "${ztcli}" join $NETWORK_ID
  while ! "${ztcli}" listnetworks | grep $NETWORK_ID | grep OK; do sleep 0.5; done
  ;;
*)
  sudo zerotier-cli join $NETWORK_ID
  while ! sudo zerotier-cli listnetworks | grep $NETWORK_ID | grep OK; do sleep 0.5; done
  ;;
esac

