FROM node:6
COPY package.json package.json
COPY main.js main.js
RUN npm install --prod

EVN PORT 80
EXPOSE 80

CMD ["npm", "start"]
