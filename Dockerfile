# We use multi-stage builds, those are: base, development, local.
# The base stage has commonalities in both development and local.

FROM node:16-alpine as base

# Create app directory
WORKDIR /usr/app

# Install app dependencies
COPY package.json ./
COPY yarn.lock ./
RUN yarn install

# Set ownership and permissions
USER node

EXPOSE 3002

## DEVELOPMENT

FROM base as development

CMD ["yarn", "run", "build"]

# Bundle app source
COPY /dist .

## LOCAL

FROM base as local

# Bundle app source
COPY . .

CMD ["yarn", "run", "dev"]