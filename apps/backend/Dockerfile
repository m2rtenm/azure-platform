FROM golang:1.23-alpine AS build
WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY main.go ./
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /backend .

FROM gcr.io/distroless/static-debian12:nonroot
COPY --from=build /backend /backend
EXPOSE 8080
USER nonroot:nonroot
ENTRYPOINT ["/backend"]
