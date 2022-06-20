package main

import (
	"github.com/alfredxiao/kubernetes-demo-controller/pkg/controller"
)

const version = "0.1.1"

func main() {
	controller.Start()
}
