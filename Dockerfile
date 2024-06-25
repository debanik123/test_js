FROM ubuntu:jammy
SHELL ["/bin/bash", "-c"]

ARG NODE_MAJOR_VER=18
RUN apt-get update -y \
    && apt-get install -y curl sudo \
    && curl -fsSL https://deb.nodesource.com/setup_${NODE_MAJOR_VER}.x | sudo -E bash - \
    && apt-get install -y nodejs

# Create and change to the app directory
COPY ./strapi_test /strapi_test

# Install dependencies
WORKDIR /strapi_test
RUN npm install && npm run build && npm rebuild bcrypt --build-from-source

# # Build the application
# RUN npm run build
# RUN npm rebuild bcrypt --build-from-source
# # Expose the necessary port
EXPOSE 1337

# # Start the application
CMD ["npm", "run", "start"]