FROM nginx:alpine

# Remove the default NGINX web content
RUN rm -rf /usr/share/nginx/html/*

# Copy your HTML/CSS/JS files to the web server directory
COPY . /usr/share/nginx/html

# Expose port 80 for web traffic
EXPOSE 80
