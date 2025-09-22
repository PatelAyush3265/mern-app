# Use Node.js LTS version
FROM node:18

# Set working directory
WORKDIR /app

# -----------------------------
# Install build tools (needed for some npm packages)
# -----------------------------
RUN apt-get update && apt-get install -y python3 make g++ && rm -rf /var/lib/apt/lists/*

# -----------------------------
# Backend
# -----------------------------
# Copy backend package files first for caching
COPY backend/package*.json ./backend/

WORKDIR /app/backend
# Install backend dependencies
RUN npm install --legacy-peer-deps

# Copy backend source code
COPY backend/ ./

# -----------------------------
# Frontend
# -----------------------------
# Change back to app directory and copy frontend package files
WORKDIR /app
COPY frontend/package*.json ./frontend/

WORKDIR /app/frontend
RUN npm install --legacy-peer-deps

# Copy the rest of frontend files
COPY frontend/ ./


# Build frontend for production
RUN npm run build

# Copy frontend build to backend public directory
WORKDIR /app
COPY frontend/build ./backend/public

# -----------------------------
# Expose backend port
# -----------------------------
EXPOSE 3000

# -----------------------------
# Start backend
# -----------------------------
WORKDIR /app/backend
CMD ["npm", "start"]
