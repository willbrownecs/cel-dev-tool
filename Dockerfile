FROM golang:1.22

WORKDIR /app

RUN go install github.com/elastic/mito/cmd/mito@latest

ENTRYPOINT ["mito"]