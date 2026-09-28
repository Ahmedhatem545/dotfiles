#!/usr/bin/env bash

CACHE_FILE="/tmp/ddc_brightness"

get_brightness() {
    if [ -f "$CACHE_FILE" ]; then
        cat "$CACHE_FILE"
    else
        val=$(ddcutil -b 1 --terse getvcp 10 2>/dev/null | awk '{print $4}')
        val=${val:-50}
        echo "$val" > "$CACHE_FILE"
        echo "$val"
    fi
}

set_brightness() {
    current=$(get_brightness)
    delta=$1
    new_val=$((current + delta))

    [ "$new_val" -gt 100 ] && new_val=100
    [ "$new_val" -lt 0 ] && new_val=0

    echo "$new_val" > "$CACHE_FILE"
    
    # Instantly trigger Waybar refresh (Signal 8)
    pkill -RTMIN+8 waybar 2>/dev/null || true
    
    # Apply change to monitor in background without blocking UI
    ddcutil -b 1 setvcp 10 "$new_val" >/dev/null 2>&1 &
}

case "${1:-}" in
    up)
        set_brightness 5
        ;;
    down)
        set_brightness -5
        ;;
    *)
        val=$(get_brightness)
        printf '{"percentage": %s}\n' "$val"
        ;;
esac
