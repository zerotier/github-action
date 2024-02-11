set -euo pipefail
IFS=$'\n\t'

case $(uname -s) in
MINGW64_NT?*)
  ztcli="/c/Program Files (x86)/ZeroTier/One/zerotier-cli.bat"
  member_id=$("${ztcli}" info | awk '{ print $3 }')
  ;;
*)
  member_id=$(sudo zerotier-cli info | awk '{ print $3 }')
  ;;
esac

echo "⏁  Removing Runner from ZeroTier network"
curl -i -s -X DELETE -H "Authorization: token $AUTH_TOKEN" "$API_URL/network/$NETWORK_ID/member/${member_id}" >/tmp/api_delete_output.txt
STATUS_CODE=$(cat /tmp/api_delete_output.txt | grep 'HTTP/' | awk '{print $2}')

if [[ $STATUS_CODE -ge 400 && $STATUS_CODE -le 599 ]]; then
  echo "ERROR: Status code: $STATUS_CODE"
  echo -e "Complete server response:\n$(cat /tmp/api_delete_output.txt)\n"
  exit $STATUS_CODE
else
  echo "Success! Status code: $STATUS_CODE"
  exit 0
fi
