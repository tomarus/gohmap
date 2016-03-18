package main

import (
	"flag"
	"fmt"
	"image"
	"image/png"
	"os"
	"path/filepath"

	"gopkg.in/qml.v1"
)

var qmlPath = flag.String("qmlpath", ".", "Path to .qml files.")
var imgPath = flag.String("imgpath", ".", "Path to .png files.")

func main() {
	flag.Parse()
	if err := qml.Run(run); err != nil {
		fmt.Fprintf(os.Stderr, "error: %v\n", err)
		os.Exit(1)
	}
}

func run() error {
	engine := qml.NewEngine()

	engine.AddImageProvider("pwd", func(id string, width, height int) image.Image {
		f, err := os.Open(filepath.Join(*imgPath, id))
		if err != nil {
			panic(err)
		}
		defer f.Close()
		image, err := png.Decode(f)
		if err != nil {
			panic(err)
		}
		return image
	})

	controls, err := engine.LoadFile(filepath.Join(*qmlPath, "main.qml"))
	if err != nil {
		return err
	}

	window := controls.CreateWindow(nil)

	window.Show()
	window.Wait()
	return nil
}
