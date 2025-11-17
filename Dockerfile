# Step 1: Build the Vite React frontend
FROM node:18 AS build
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy rest of code
COPY . .

# Build for production
RUN npm run build

# Step 2: Serve the built files with NGINX
FROM nginx:alpine

# Copy build output (Vite outputs to /dist)
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
