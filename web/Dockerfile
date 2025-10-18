# Multi-stage build for React application
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package files first for better caching
COPY package*.json ./

# Install all dependencies (including devDependencies for build)
RUN npm ci

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Production stage - just create the build artifacts
# Nginx will be handled by the main docker-compose setup
FROM scratch AS dist
COPY --from=builder /app/dist /dist
