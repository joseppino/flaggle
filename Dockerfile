FROM node:22-alpine AS sk-build
WORKDIR /usr/src/app

ARG TZ=Europe/London

COPY . /usr/src/app
RUN apk --no-cache add curl tzdata
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN npm install --legacy-peer-deps
RUN npm run build

FROM node:22-alpine
WORKDIR /usr/src/app

ARG TZ=Europe/London
RUN apk --no-cache add curl tzdata
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY --from=sk-build /usr/src/app/package.json /usr/src/app/package.json
COPY --from=sk-build /usr/src/app/package-lock.json /usr/src/app/package-lock.json

RUN npm i --omit=dev

COPY --from=sk-build /usr/src/app/build /usr/src/app/build

EXPOSE 7668
CMD PORT=7668 node build