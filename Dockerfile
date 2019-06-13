# MULTI STEP DOCKER FILE:::
# Docker file used to construct a image used for production environment. Note in production we will not use volumes (mappings) that
# we used in dev during development. Also not in a node app, the final artifact that is packaged when using 'npm run build' command
# will be put in the /app/build directory of the node application
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Second phase - 'FROM' indicates the end of the previous FROM block and starts a new one
FROM nginx
EXPOSE 80
# copy the '/app/build/' from builder phase into into /nginx/html/ on container. 
COPY --from=builder /app/build /usr/share/nginx/html