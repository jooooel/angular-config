# This is the image we use to build the angular application
FROM node:12.18.2-alpine AS node-build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# This is the final image we use to run the angular application
# Copy the output of the build into this image.
FROM nginx:1.19-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=node-build /app/dist/angular-config /usr/share/nginx/html