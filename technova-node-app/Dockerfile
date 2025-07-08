FROM node:22-bullseye-slim

WORKDIR /app

COPY . . 

 
RUN npm install

RUN npm install -g nodemon express mongoose

EXPOSE 3000

CMD ["nodemon", "app.js"]
