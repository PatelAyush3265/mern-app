# Base image
FROM node:18

# Set working directory
WORKDIR /app

# Copy backend and install
COPY backend ./backend
WORKDIR /app/backend
RUN npm install

# Copy frontend and install
COPY frontend ./frontend
WORKDIR /app/frontend
RUN npm install

# Expose backend port
EXPOSE 3000

# Start backend
WORKDIR /app/backend
CMD ["npm", "start"]
