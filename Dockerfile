# Use Node.js LTS version
FROM node:18

# Set working directory
WORKDIR /app

# -----------------------------
# Backend
# -----------------------------
# Copy only package files first for caching
COPY backend/package*.json ./backend/

WORKDIR /app/backend

# Install backend dependencies with legacy-peer-deps to avoid conflicts
RUN npm install --legacy-peer-deps

# Copy the rest of the backend code
COPY backend/ ./

# -----------------------------
# Frontend
# -----------------------------
# Copy only package files first for caching
COPY frontend/package*.json ./frontend/

WORKDIR /app/frontend

# Install frontend dependencies
RUN npm install --legacy-peer-deps

# Copy the rest of the frontend code
COPY frontend/ ./

# -----------------------------
# Expose backend port
# -----------------------------
EXPOSE 3000

# -----------------------------
# Start backend
# -----------------------------
WORKDIR /app/backend
CMD ["npm", "start"]
