FROM golang:1.19-alpine AS build
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -o gopher-eshu-demo .

FROM alpine:3.20
RUN apk --no-cache add ca-certificates
WORKDIR /app
COPY --from=build /app/gopher-eshu-demo .
EXPOSE 8080
LABEL name="gopher-eshu-demo"

ENTRYPOINT ["./gopher-eshu-demo"]