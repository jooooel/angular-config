# This is the base of our final image, has nginx.
FROM nginx:1.19-alpine as nginx-base
COPY nginx.conf /etc/nginx/nginx.conf

# Install jq and gawk.
# We need this to be able to overwrite config based on environment variables.
RUN apk update && apk add jq=1.6-r1 gawk=5.1.0-r0

# This is the image we use to build the angular application.
FROM node:12.18.2-alpine AS node-build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Switch to the final runtime image.
FROM nginx-base as final

# Copy and make the entrypoint script executable.
# This will be used to make sure we use the correct configuration (based on env variables).
COPY --from=node-build /app/entrypoint.sh docker-entrypoint.d/40-entrypoint.sh
RUN chmod +x docker-entrypoint.d/40-entrypoint.sh

# Copy the outputs from the build.
COPY --from=node-build /app/dist/angular-config /usr/share/nginx/html