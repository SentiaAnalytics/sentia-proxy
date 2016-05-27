FROM node:6.2

COPY package.json package.json
ADD src src

RUN npm install
RUN npm run build

ENV PORT 80
EXPOSE 80

CMD ["npm", "start"]
