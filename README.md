GOHMAP
======

Simple golang heightmap generator and viewer.

The heightmap generator uses a Square Diamond algorithm to generate a random 16bit grayscale image. The heightmap viewer uses experimental go-qml to display a nice visualization of the generated heightmap.

# Installation

First install Qt5.5 as described here https://github.com/go-qml/qml

Then install the Qt5.7-alpha Datavisualization module. Just unzip it and type `qmake`

Build the heightmap utiltites manually or just type `make` for convenience.

# Operation

Create a simple heightmap:
```
./hmgen -o /tmp/test.png
```

View the generated heightmap (defaults to test.png)
```
./hmview -imgpath /tmp -qmlpath ./qml
```

Try out some more options:
```
./hmgen -o /tmp/test.png -samples 512 ; ./hmview -imgpath /tmp -qmlpath ./qml
```

# Disclaimer

This is just a little experiment.

![preview](http://s.chiparus.org/7/7d5b5514e1baf544.png)
