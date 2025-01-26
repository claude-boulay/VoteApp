FROM node:18-alpine

WORKDIR /usr/src/app/

COPY . ./

RUN npm install
#Ajouter le port pour que les autres application sache quel ports écouté
EXPOSE 8888

CMD ["npm","run","start"]