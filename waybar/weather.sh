#!/bin/bash

# Configuration
API_KEY="a04d1ecbb2404f86a2d203526252712"
LOCATION="27401" # Or "Greensboro"
UNITS="f" # 'c' for Celsius, 'f' for Fahrenheit

# Fetch data
weather=$(curl -s "http://api.weatherapi.com/v1/current.json?key=$API_KEY&q=$LOCATION&aqi=no")

# Check if the request was successful
if [[ $(echo "$weather" | jq -r '.error') != "null" ]] || [[ -z "$weather" ]]; then
    echo '{"text":"󰖐 ?"}'
    exit 1
fi

# Extract data
temp=$(echo "$weather" | jq -r ".current.temp_$UNITS | round")
condition=$(echo "$weather" | jq -r '.current.condition.text')

# Map conditions to icons
case "$condition" in
    "Clear"|"Sunny") icon="☀️" ;;
    "Partly cloudy") icon="⛅" ;;
    "Cloudy"|"Overcast") icon="☁️" ;;
    "Mist"|"Fog"|"Freezing fog") icon="🌫️" ;;
    "Patchy rain possible"|"Light rain"|"Moderate rain") icon="🌦️" ;;
    "Heavy rain"|"Torrential rain shower") icon="🌧️" ;;
    "Thundery outbreaks possible"|"Patchy light rain with thunder") icon="⛈️" ;;
    *) icon="🌡️" ;;
esac

# Output for Waybar
echo "{\"text\":\"$icon $temp°$UNITS\", \"tooltip\":\"$condition in Greensboro\"}"
