#!/bin/bash
# Get current time in HHMM format
TIME=$(date +%H%M)

# If time is >= 17:25 OR <= 07:30
if [ "$TIME" -ge 1725 ] || [ "$TIME" -le 0730 ]; then
    # Start hyprsunset if not already running
    pgrep hyprsunset || hyprsunset -t 5000 &
fi
