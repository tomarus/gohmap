import QtQuick 2.1
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.0
import QtDataVisualization 1.2
import "."

Rectangle {
    id: mainview
    width: 1280
    height: 768

    Item {
        id: surfaceView
        width: mainview.width - buttonLayout.width
        height: mainview.height
        anchors.right: mainview.right

        ColorGradient {
            id: surfaceGradient
            ColorGradientStop { position: 0.0; color: "darkslategray" }
            ColorGradientStop { id: middleGradient; position: 0.750; color: "peru" }
            ColorGradientStop { position: 1.0; color: "white" }
        }

        Image {
            source: "image://pwd/test.png"
            cache: false
            id: pietje
        }

        Surface3D {
            id: surfacePlot
            width: surfaceView.width
            height: surfaceView.height
            theme: Theme3D {
                type: Theme3D.ThemeEbony
                font.family: "STCaiyun"
                font.pointSize: 35
                colorStyle: Theme3D.ColorStyleRangeGradient
                baseGradients: [surfaceGradient]
            }
            shadowQuality: AbstractGraph3D.ShadowQualityMedium
            selectionMode: AbstractGraph3D.SelectionSlice | AbstractGraph3D.SelectionItemAndRow
            scene.activeCamera.cameraPreset: Camera3D.CameraPresetIsometricLeft
            axisY.min: 0.0
            axisY.max: 250.0
            axisX.segmentCount: 8
            axisX.subSegmentCount: 1
            axisX.labelFormat: "%i"
            axisZ.segmentCount: 8
            axisZ.subSegmentCount: 1
            axisZ.labelFormat: "%i"
            axisY.segmentCount: 5
            axisY.subSegmentCount: 1
            axisY.labelFormat: "%i"
            axisY.title: "Height"
            axisX.title: "Latitude"
            axisZ.title: "Longitude"

            Surface3DSeries {
                id: heightSeries
                flatShadingEnabled: false
                drawMode: Surface3DSeries.DrawSurface
                visible: true

                HeightMapSurfaceDataProxy {
                    heightMapFile: "/tmp/test.png"
                    minZValue: 0
                    maxZValue: 1023
                    minXValue: 0
                    maxXValue: 1023
                }
            }
        }
    }

    ColumnLayout {
        id: buttonLayout
        anchors.top: parent.top
        anchors.left: parent.left
        spacing: 0
        opacity: 1.0

        NewButton {
            id: surfaceGridToggle
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "Toggle Surface Grid"
            onClicked: {
                if (heightSeries.drawMode & Surface3DSeries.DrawWireframe) {
                    heightSeries.drawMode &= ~Surface3DSeries.DrawWireframe;
                } else {
                    heightSeries.drawMode |= Surface3DSeries.DrawWireframe;
                }
            }
        }

        NewButton {
            id: backgroundToggle
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "Hide Background"
            onClicked: {
                if (surfacePlot.theme.backgroundEnabled === true) {
                    surfacePlot.theme.backgroundEnabled = false;
                    text = "Show Background"
                } else {
                    surfacePlot.theme.backgroundEnabled = true;
                    text = "Hide Background"
                }
            }
        }

        NewButton {
            id: gridToggle
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "Hide Grid"
            onClicked: {
                if (surfacePlot.theme.gridEnabled === true) {
                    surfacePlot.theme.gridEnabled = false;
                    text = "Show Grid"
                } else {
                    surfacePlot.theme.gridEnabled = true;
                    text = "Hide Grid"
                }
            }
        }
    }
}
