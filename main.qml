import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4

Window {
    visible: true
    width: 800
    height: 500
    title: qsTr("Cluster")

    Rectangle{

        Keys.onPressed:{
            if (event.key == Qt.Key_R){
                changeGear("1")
            } else if (event.key == Qt.Key_D){
                changeGear("3")
            }else if (event.key == Qt.Key_P){
                changeGear("0")
            }else if(event.key == Qt.Key_N){
                changeGear("2")
            } else if(event.key == Qt.Key_1){
                changeSignal("left")
            } else if (event.key == Qt.Key_3){
                changeSignal("right")
            }

        }
        id: background
        width: 800
        height: 500
        color: "black"
        anchors { centerIn: parent }

        // 左仪表.
        SpeedBars{
            id: leftSpeed
            property bool accelerate
            value: accelerate ? maximumValue : 0
            antialiasing: true
            maximumValue: 240
            Component.onCompleted: forceActiveFocus()
            Behavior on value { NumberAnimation { duration: 2000 }}
            Keys.onSpacePressed: accelerate = true;

            Keys.onReleased: {
                if (event.key === Qt.Key_Space) {

                    accelerate = false;
                    event.accepted = true;
                }
            }

            Text {
                    width: 60
                    color: "#56fdff"
                    text: leftSpeed.value.toFixed(0) + " km/h"

                    y: 220
                    x:100
            }

        }

        function changeGear(gearData){
            lGear.currentGearId = gearData
        }
        function changeSignal(signalData){
            if (signalData == "left"){

                if (!turn_left.visible){

                   turn_left.visible = true;
                } else if ( turn_left.visible){
                    turn_left.visible = false;
                }

            } else if (signalData == "right"){
                if (!turn_right.visible){

                   turn_right.visible = true;
                } else if ( turn_right.visible){
                    turn_right.visible = false;
                }

            }

        }

        Gears {
                id: lGear
                x: 357
                y: 500
                currentGearId: "0"
                anchors{
                    horizontalCenter: background.horizontalCenter
                    centerIn: background
                }

        }
        //当前时间
        Text {
            id: clock
            text: "Clock"
            color: "white"
            anchors{
                horizontalCenter: background.horizontalCenter

            }
            y: 50
        }
        Text {
            id: dayInfo
            text: "Date"
            color: "white"
            anchors{
                horizontalCenter: background.horizontalCenter

            }
            y: 75 }
        Timer {
            interval: 500
            running: true
            repeat: true

            onTriggered: {
                var date = new Date()
                clock.text = date.toLocaleTimeString(Qt.locale("vi_VN"), "HH:mm:ss")
                dayInfo.text = date.toLocaleDateString(Qt.locale("vi_VN"))

            }
        }

        // 右仪表.
        CircularGauge{
            property bool accelerate1
            value: 0
            id: rightSpeed
            maximumValue: 80

            anchors{
                verticalCenter: background.verticalCenter
                right: background.right
            }

            Behavior on value {
                NumberAnimation{
                    duration: 3000
                    easing.type: Easing.OutQuad

                }
            }

        }
        Timer{
            repeat: true
            running: true
            interval:  2000
            onTriggered: {
                var data = Math.floor(Math.random() * 90) + 0
                rightSpeed.value = data
            }
        }
        //转向标志
        Image{
            id:turn_left
            x:247
            y:95
            opacity: 1
            smooth: true

            source: "Turn_Left.png"
            width: 25
            height:25
            antialiasing: true
            visible: true
        }

        Image {
            id:turn_right
            source: "Turn_Right.png"
            y:95
            x: 528
            width: 25
            height: 25
            visible: true
        }
        //商标
        Image {
            source: "trademark.png"
            width: 90
            height: 65
            anchors{
                horizontalCenter: background.horizontalCenter

            }
            y:300

        }

    }

}
