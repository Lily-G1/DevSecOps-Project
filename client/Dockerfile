# Stage 1: Build React App
FROM node:22-alpine AS builder

ARG REACT_APP_API
ENV REACT_APP_API=$REACT_APP_API

WORKDIR /app

# Only copy dependency descriptors first to leverage Docker cache
COPY package.json package-lock.json ./

# Clean and fast install using lock file (CI-style)
RUN npm ci

# Copy the rest of app source
COPY . .

# Build the React app (generates static files in /build)
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy built static files from builder stage
COPY --from=builder /app/build /usr/share/nginx/html

# Add custom nginx config 
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Expose port 80 for HTTP
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]

