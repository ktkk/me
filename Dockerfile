FROM alpine:3.15

RUN apk update
RUN apk add \
	make \
	npm

RUN npm install -g \
	sass \
	typescript

WORKDIR personal_website

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
