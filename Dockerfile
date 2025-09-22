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
# Copy only package files first for caching
COPY backend/package*.json ./backend/

WORKDIR /app/backend

# Install backend dependencies
RUN npm install --legacy-peer-deps

# Copy backend source code
COPY backend/ ./

# -----------------------------
# Frontend
# -----------------------------
# Copy only package files first for caching
COPY frontend/package*.json ./frontend/

WORKDIR /app/frontend

# Install frontend dependencies
RUN npm install --legacy-peer-deps

# Copy frontend source code
COPY frontend/ ./

# Build frontend for production
RUN npm run build

# -----------------------------
# Expose backend port
# -----------------------------
EXPOSE 3000

# -----------------------------
# Serve frontend from backend (optional)
# If you want backend to serve frontend files:
# -----------------------------
# COPY frontend/build ./backend/public

# -----------------------------
# Start backend
# -----------------------------
WORKDIR /app/backend
CMD ["npm", "start"]
