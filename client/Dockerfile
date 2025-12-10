# Stage 1: Build React App
FROM node:22-alpine AS builder

WORKDIR /app

# Copy only dependency descriptors first to leverage Docker cache
COPY package.json package-lock.json ./

# Install using lock file
RUN npm ci

# Copy the rest of source files
COPY . .

# Build React app (generates static files in /build)
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy built static files from builder stage
COPY --from=builder /app/build /usr/share/nginx/html

# Add custom nginx config
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Expose port 80 for HTTP
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
