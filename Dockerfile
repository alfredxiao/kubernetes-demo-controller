FROM golang:1.18-alpine as builder
RUN mkdir -p /go/src/github.com/alfredxiao/kubernetes-demo-controller
ADD . /go/src/github.com/alfredxiao/kubernetes-demo-controller
WORKDIR /go/src/github.com/alfredxiao/kubernetes-demo-controller
RUN CGO_ENABLED=0 GOOS=linux go mod init github.com/alfredxiao/kubernetes-demo-controller
RUN CGO_ENABLED=0 GOOS=linux go mod tidy
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o demo-controller .

FROM alpine:3.7  
WORKDIR /
COPY --from=builder /go/src/github.com/alfredxiao/kubernetes-demo-controller/demo-controller .
CMD ["/demo-controller"] 
