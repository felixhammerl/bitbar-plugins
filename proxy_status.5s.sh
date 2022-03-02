#!/bin/bash

interface="Wi-Fi"
proxy_type="Burp"
proxy_get_http="-getwebproxy"
proxy_get_https="-getsecurewebproxy"
proxy_set_http="-setsecurewebproxystate"
proxy_set_https="-setwebproxystate"
proxy_conf_http="-setwebproxy"
proxy_conf_https="-setsecurewebproxy"

state=$(networksetup $proxy_get_http $interface | grep "No")

if [ "$1" = 'toggle' ]; then
  if [ -n "$state" ]; then
    networksetup $proxy_conf_http $interface localhost 8080
    networksetup $proxy_conf_https $interface localhost 8080
    networksetup $proxy_set_http $interface on
    networksetup $proxy_set_https $interface on
  else
    networksetup $proxy_set_http $interface off
    networksetup $proxy_set_https $interface off
  fi

  exit
fi

if [ -n "$state" ]; then
  state_icon="✘"
  action_toggle="Enable"
else
  state_icon="✔"
  action_toggle="Disable"
fi

echo "$state_icon $proxy_type | dropdown=false"
echo "---"
echo "$action_toggle $proxy_type | bash='$0' param1=toggle terminal=false refresh=true"
