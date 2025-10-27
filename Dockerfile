# Use official Node.js image
FROM node:18

# Set working directory
WORKDIR /app

# Copy only package files first (for caching)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the project (including /app folder)
COPY . .

# Expose port 3000
EXPOSE 3000

# Start the app from inside /app/app
CMD ["node", "index.js"]
