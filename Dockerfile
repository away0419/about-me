FROM node:latest
WORKDIR /app
COPY package.json ./
RUN npm i -g 
RUN npm i -g @vue/cli
COPY ./ .
RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]