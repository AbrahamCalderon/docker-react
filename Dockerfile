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
# copy the '/app/build/'' folder into /nginx/html/. 
# Syntax: we want to copy something over from the 'builder' phase above, 
# followed by the folder we want to copy (/app/buil) and to
# the destination on the container (/usr/share/nginx/html)
COPY --from=builder /app/build /usr/share/nginx/html


