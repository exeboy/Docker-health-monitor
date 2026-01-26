FROM nginx:alpine

# Install 'procps' so we have access to the 'free' command
RUN apk add --no-cache procps

# Copy our script and give it execution permissions
COPY monitor.sh /usr/local/bin/monitor.sh
RUN chmod +x /usr/local/bin/monitor.sh

# Start the script AND Nginx
# Using 'sh -c' allows us to run two commands at once
CMD ["sh", "-c", "/usr/local/bin/monitor.sh & nginx -g 'daemon off;'"]
