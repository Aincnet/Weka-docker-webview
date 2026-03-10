#!/bin/bash
set -e

export DISPLAY=:1

rm -f /tmp/.X1-lock || true

echo "[+] Starting Xvfb..."
Xvfb :1 -screen 0 1280x800x24 &

sleep 2

echo "[+] Starting Fluxbox..."
fluxbox &

echo "[+] Starting x11vnc..."
x11vnc -display :1 -nopw -forever -shared &

echo "[+] Starting noVNC..."
websockify --web=/usr/share/novnc 6080 localhost:5900 &

echo "[+] Starting Weka..."
#exec /opt/weka/weka.sh
exec java -Xms512m -Xmx2g -jar /opt/weka/weka.jar
