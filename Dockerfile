FROM node:latest as build-stage
WORKDIR /app
COPY package.json ./
RUN npm i -g @vue/cli@5.0.8
RUN npm i -g 
COPY ./ .
RUN npm run serve

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]