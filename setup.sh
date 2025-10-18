#!/bin/bash
# Flavorbase Setup Script
# This script prepares the environment for Docker deployment

set -e

echo "🍳 Setting up Flavorbase for Docker deployment..."

# Create necessary directories
echo "📁 Creating directories..."
mkdir -p nginx/ssl
mkdir -p database

# Build frontend first (required for nginx volume)
echo "🏗️ Building frontend..."
cd web
npm install
npm run build
cd ..

# Generate SSL certificates for HTTPS (optional)
if [ ! -f "nginx/ssl/cert.pem" ]; then
    echo "🔐 Generating self-signed SSL certificates..."
    docker run --rm -v $(pwd)/nginx/ssl:/certs alpine/openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /certs/key.pem \
        -out /certs/cert.pem \
        -subj "/C=US/ST=CA/L=San Francisco/O=Flavorbase/OU=Development/CN=localhost"
    echo "✅ SSL certificates generated"
else
    echo "🔐 SSL certificates already exist"
fi

# Set permissions
chmod 600 nginx/ssl/key.pem 2>/dev/null || true
chmod 644 nginx/ssl/cert.pem 2>/dev/null || true

echo "🚀 Setup complete! You can now run:"
echo ""
echo "  docker compose up --build"
echo ""
echo "Then access:"
echo "  HTTP:  http://localhost:3000"
echo "  HTTPS: https://localhost:3443 (self-signed certificate)"
echo "  API:   http://localhost:3000/api/actuator/health"
echo ""
echo "🎉 Happy cooking!"
