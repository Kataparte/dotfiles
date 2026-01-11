#!/bin/bash
# Check if live-server is running on port 8080
if lsof -Pi :8080 -sTCP:LISTEN -t >/dev/null; then
  echo "active"
else
  echo "inactive"
fi
