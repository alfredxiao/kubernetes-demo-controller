FROM golang:1.18-alpine as builder
RUN mkdir -p /go/src/github.com/piontec/k8s-demo-controller
ADD . /go/src/github.com/piontec/k8s-demo-controller
WORKDIR /go/src/github.com/piontec/k8s-demo-controller
# COPY vendor/ ./vendor/
# COPY pkg/ ./pkg/
# COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go mod init github.com/piontec/k8s-demo-controller
RUN CGO_ENABLED=0 GOOS=linux go mod tidy
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o demo-controller .

FROM alpine:3.7  
WORKDIR /
COPY --from=builder /go/src/github.com/piontec/k8s-demo-controller/demo-controller .
CMD ["/demo-controller"] 
