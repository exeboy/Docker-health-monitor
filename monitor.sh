#!/bin/sh

# The location Nginx looks for files
HTML_FILE="/usr/share/nginx/html/index.html"

while true; do
    # Gather stats
    UPTIME=$(uptime -p)
    DISK=$(df -h | grep '^/dev/' | head -1 | awk '{print $5}')
    MEMORY=$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')

    # Generate HTML
    cat <<EOF > $HTML_FILE
    <html>
    <head>
        <title>Container Health</title>
        <meta http-equiv="refresh" content="10">
        <style>
            body { font-family: sans-serif; background: #222; color: #0f0; text-align: center; }
            .stat { font-size: 2em; margin: 20px; border: 1px solid #0f0; padding: 10px; }
        </style>
    </head>
    <body>
        <h1>System Health Dashboard</h1>
        <div class="stat">Uptime: $UPTIME</div>
        <div class="stat">Disk Usage: $DISK</div>
        <div class="stat">Memory Usage: $MEMORY</div>
        <p>Last Update: $(date)</p>
    </body>
    </html>
EOF
    sleep 10
done
