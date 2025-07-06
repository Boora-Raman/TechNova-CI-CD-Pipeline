FROM node:22-bullseye-slim

WORKDIR /app

COPY . .

RUN npm install

EXPOSE 3000

CMD ["nodemon", "app.js"]
