FROM alpine:3.15

RUN apk update
RUN apk add \
	clang \
	make \
	python3 \
	npm

RUN npm install -g \
	sass \
	typescript

EXPOSE 8000

WORKDIR personal_website

COPY . .

CMD ["make", "run"]
