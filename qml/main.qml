import QtQuick 2.9
import QtQuick.Window 2.2

import "./item" //在不同目录下文件,导入目录

Window {
    visible: true
    width: 600
    height: 480
    title: qsTr("qml学习")

   //M_MouseArea{}
   // M_Drag{}

//Behavior: 用于与一个属性绑定，当该属性发生变化时就执行该动画.
//@@. 一个属性只能绑定一个Behavior,一个Behavior里面只能有一个顶层的动画,
//想执行多个动画时，使用ParallelAnimation或者SequentialAnimation.
//@@. 如果定义的Transition里面执行的动画，所绑定的属性与Behavior绑定的属性
//相同，那么Transiton会覆Behavior.
//animation: 默认动画属性
//enable: 使能动画
/*
    Rectangle {
          id: rect
          width: 100; height: 100
          color: "red"

          Behavior on width {
              NumberAnimation { duration: 1000 }
          }

          MouseArea {
              anchors.fill: parent
              onClicked: rect.width = 50
          }
      }
*/


//ParentAnimation: 用于当一个Item项改变其父对象时执行动画。
//ParentAnimation通常在Transition中与ParentChange一起使用,
//以这种方式使用时，它会动态在状态更改期间发生的任何ParentChange,
//可以使用target属性设置特定目标项来覆盖此项。
/*
newParent : Item  //目标的新Parent
target : Item     //目标对象
via : Item        //动画过程中参考其他的对象.
*/
/*
    Item {
          width: 200; height: 100

          Rectangle {
              id: redRect
              width: 100; height: 100
              color: "red"
          }

          Rectangle {
              id: blueRect
              x: redRect.width
              width: 50; height: 50
              color: "blue"

              states: State {
                  name: "reparented"
                  ParentChange {
                      target: blueRect;
                      parent: redRect; //改变parent对象
                      x: 10; y: 10  //新parent的位置
                  }
              }

              transitions: Transition {
                  ParentAnimation { //ParentAnimation可以包含多个动画对象
                      NumberAnimation {
                          properties: "x,y"; //绑定的是属性的改变
                          duration: 1000
                      }
                  }
              }

              MouseArea {
                  anchors.fill: parent;
                  onClicked: blueRect.state = "reparented" //改变状态
              }
          }
      }
*/
/*
    Rectangle {
        width: 360;
        height: 240;
        color: "#EEEEEE";
        id: rootItem;

        Rectangle {
            id: blueRect;
            width: 200;
            height: 200;
            color: "blue";
            x: 8;
            y: 8;
        }

        Rectangle {
            id: redRect;
            color: "red";
            state: "default"; //默认状态时,程序开始运行时会执行一次

            MouseArea {
                id: mouseArea;
                anchors.fill : parent;
                onClicked: {
                    if( redRect.state == "" || redRect.state == "default" ) {
                        redRect.state = "reparent";
                    }else {
                        redRect.state = "default";
                    }
                }
            }

            states: [
                State {
                    name: "reparent";
                    ParentChange {
                        target: redRect;
                        parent: blueRect;
                        width: 50;
                        height: 50;
                        x: 30;
                        y: 30;
                        rotation:45;
                    }
                },
                State {
                    name: "default";
                    ParentChange {
                        target: redRect;
                        parent: rootItem;
                        width: 100;
                        height: 100;
                        x: blueRect.x + blueRect.width + 8;
                        y: blueRect.y;
                    }
                }
            ]

            transitions: Transition {
                ParentAnimation { //上面有多个属性发生改变,这里只绑定x,y属性值.
                                  //其他属性的改变不会有动画效果。
                    NumberAnimation { properties: "x,y"; duration: 1000 }
                }
            }
        }
    }
*/

//AnchorAnimation: 用于锚的改变时执行的动画.
/*
在Transition中使用AnchorAnimation时，它将为state改变期间发生的任何AnchorChange设置动画.
可以使用AnchorChanges.target属性设置特定目标项来覆盖此设置。
注意：AnchorAnimation只能在Transition中使用，和AnchorChange一起使用.它不能用于Behavior
和其他类型的动画。
//属性:
duration : int  //持续的时间
easing
easing.type : enumeration
easing.amplitude : real
easing.overshoot : real
easing.period : real
targets : list<Item> //目标对象列表
*/
/*
    Item {
         id: container
         width: 200; height: 200

         Rectangle {
             id: myRect
             width: 100; height: 100
             color: "red"
         }

         MouseArea{
            anchors.fill: myRect
            onClicked: container.state = "reanchored"
         }

         states: State {
             name: "reanchored"
             AnchorChanges {
                 target: myRect;
                 anchors.right: container.right
             }
         }

         transitions: Transition {
             // smoothly reanchor myRect and move into new position
             AnchorAnimation { duration: 1000 }
         }

         //Component.onCompleted: container.state = "reanchored"
     }
*/

/*
    Rectangle {
        id: rootItem;
        width: 360;height: 240;
        color: "#EEEEEE";

        Rectangle {
            id: blueRect;
            width: 200; height: 180;
            color: "blue";
            x: 8; y: 8;
        }

        Rectangle {
            id: redRect;
            color: "red";
            width: 100; height: 100;
            anchors.leftMargin: 10;

            MouseArea {
                id: mouseArea;
                anchors.fill : parent;
                onClicked: {
                    if( redRect.state == "" || redRect.state == "default" ) {
                        redRect.state = "reanchor";
                    }else {
                        redRect.state = "default";
                    }
                }
            }

            states: [
                State {
                    name: "reanchor";
                    changes:[
                        AnchorChanges {
                            target: redRect;
                            anchors.top: blueRect.bottom;
                            anchors.left: rootItem.left;
                        },
                        PropertyChanges {
                            target: redRect;
                            height: 40;
                            anchors.topMargin: 4;
                        }
                    ]
                },
                State {
                    name: "default";
                    AnchorChanges {
                        target: redRect;
                        anchors.left: blueRect.right;
                        anchors.top: blueRect.top;
                    }
                }
            ]

            state: "default";

            transitions: Transition{
                AnchorAnimation{
                    duration: 1000;
                    //easing.type: Easing.OutInCubic;
                }
            }
        }
    }
*/

//PauseAnimation:
//在SequentialAnimation中使用时，PauseAnimation是在指定的持续时间内没有任何反应的步骤。

//PropertyAction
/*
    Item {
          width: 400; height: 400

          Rectangle {
              id: rect
              width: 200; height: 100
              color: "red"

              states: State {
                  name: "rotated"
                  PropertyChanges {
                      target: rect;
                      rotation: 180;
                      transformOrigin: Item.BottomRight
                  }
              }

              transitions: Transition {
//                  RotationAnimation { //绑定的属性是"rotation"
//                      duration: 4000;
//                      direction: RotationAnimation.Counterclockwise
//                  }
                  SequentialAnimation {
                           PropertyAction { target: rect; property: "transformOrigin" }
                           RotationAnimation { duration: 1000; direction: RotationAnimation.Counterclockwise }
                       }
              }

              MouseArea {
                  anchors.fill: parent
                  onClicked: rect.state = "rotated"
              }
          }
      }
*/


    Rectangle {
        id: mixBox
        width: 50
        height: 50
        color: "lightgray"
        MouseArea{
            anchors.fill: parent
            onClicked: anim.start()
        }

        SequentialAnimation{
        //ParallelAnimation {
            id: anim
//            ColorAnimation {
//                target: mixBox
//                property: "color"
//                from: "forestgreen"
//                to: "lightsteelblue";
//                duration: 1000
//            }
            ScaleAnimator {
                target: mixBox
                from: 2
                to: 1
                duration: 1000
            }
            //running: true
        }
    }














}
