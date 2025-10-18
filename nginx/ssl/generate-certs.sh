#!/bin/bash
# Generate self-signed SSL certificates for development

# Create the SSL directory if it doesn't exist
mkdir -p /etc/nginx/ssl

# Generate private key
openssl genrsa -out /etc/nginx/ssl/key.pem 2048

# Generate certificate signing request
openssl req -new -key /etc/nginx/ssl/key.pem -out /etc/nginx/ssl/cert.csr -subj "/C=US/ST=CA/L=San Francisco/O=Flavorbase/OU=Development/CN=localhost"

# Generate self-signed certificate
openssl x509 -req -days 365 -in /etc/nginx/ssl/cert.csr -signkey /etc/nginx/ssl/key.pem -out /etc/nginx/ssl/cert.pem

# Set proper permissions
chmod 600 /etc/nginx/ssl/key.pem
chmod 644 /etc/nginx/ssl/cert.pem

# Clean up
rm /etc/nginx/ssl/cert.csr

echo "Self-signed SSL certificates generated successfully!"
echo "Certificate: /etc/nginx/ssl/cert.pem"
echo "Private Key: /etc/nginx/ssl/key.pem"
