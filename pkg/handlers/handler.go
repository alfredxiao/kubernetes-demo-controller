package handlers

import (
	"github.com/sirupsen/logrus"
	api_v1 "k8s.io/api/core/v1"
)

// Handler is implemented by any handler.
// The Handle method is used to process event
type Handler interface {
	Init() error
	ObjectCreated(obj interface{})
	ObjectDeleted(obj interface{})
	ObjectUpdated(oldObj, newObj interface{})
}

// Map maps each event handler function to a name for easily lookup
var Map = map[string]interface{}{
	"default": &Default{},
}

// Default handler implements Handler interface,
// print each event with JSON format
type Default struct {
}

// Init initializes handler configuration
// Do nothing for default handler
func (d *Default) Init() error {
	return nil
}

func (d *Default) ObjectCreated(obj interface{}) {
	pod := obj.(*api_v1.Pod)
	logrus.WithFields(logrus.Fields{
		"pod":       pod.Name,
		"namespace": pod.Namespace,
	}).Infof("created")
}

func (d *Default) ObjectDeleted(obj interface{}) {
	pod := obj.(*api_v1.Pod)
	logrus.WithFields(logrus.Fields{
		"pod":       pod.Name,
		"namespace": pod.Namespace,
	}).Infof("deleted")
}

func (d *Default) ObjectUpdated(oldObj, newObj interface{}) {
	pod := oldObj.(*api_v1.Pod)
	logrus.WithFields(logrus.Fields{
		"pod":       pod.Name,
		"namespace": pod.Namespace,
	}).Infof("updated")
}
