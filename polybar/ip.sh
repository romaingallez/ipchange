#!/bin/bash

t=0
sleep_pid=0
ip_change_response='{}'
last_call_time=0

toggle() {
    t=$(((t + 1) % 2))

    if [ "$sleep_pid" -ne 0 ]; then
        kill $sleep_pid >/dev/null 2>&1
    fi
}

call_ipchange() {
    current_time=$(date +%s)
    if ((current_time - last_call_time >= 300)); then
        # echo "calling ipchange"
        echo $(/home/rogafe/dev/go/ipchange/ipchange)
        last_call_time=$current_time
    fi
}

trap "toggle" USR1

while true; do
    # echo "t: $t"
    ip_change_response=$(call_ipchange)
    if [ $t -eq 0 ]; then
        echo "LAN: $(ip route get 1 | awk '{print $7}') WAN: $(echo $ip_change_response | jq -r .'public_op')"
        # echo "$(echo $ip_change_response)" 
    else
        echo "LAN $(ip route get 1 | awk '{print $7}')"

        

        # echo $IPINFO  | jq -r '.ip + " - " + .org'
    fi
    sleep 1 &
    sleep_pid=$!
    wait
done
