import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls 2.2

/*
    Rectangle{
      id: rect
      width: 480; height: 320
      property bool mouseStatus: false  //自定义的一个属性
      color: "lightblue"

      onMouseStatusChanged: { //属性发生改变时，触发信号
          if(mouseStatus){
              rect.color="gray"
          }
          else{
              rect.color = "lightblue" //改变颜色
          }
      }
      MouseArea{
         anchors.fill: parent
         hoverEnabled: true  //使能鼠标域内的hover
         onEntered: rect.mouseStatus=true //鼠标进入
         onExited: rect.mouseStatus=false //鼠标离开
         cursorShape: Qt.OpenHandCursor //只能在鼠标区域能改变鼠标状态
         onPressed: rect.color = "red" //鼠标按下
      }
    }
*/

/*
propagateComposedEvents: 用于设置，当上下层鼠标区域发生重叠时,是否将鼠标事件传递到
底层中的鼠标接收区域。当设置为true时，鼠标事件会传递。鼠标事件以堆叠顺序传播到其下方的下
一个启用的MouseArea，直到MouseArea接收该事件,即 mouse.accepted = true时事件就停止
向下传输.用于子项控制父项是否能接受到鼠标事件.
*/
/*
containsPress:用于判断鼠标是否在鼠标区域内
containsMouse:用于判断鼠标在鼠标区域内,并且鼠标是否是按下状态
drag.active表明目标item当前是否正在被拖动
drag.filterChildren为true时，鼠标事件可被父对象接收

//一般可以设置的属性,基本都有对应的信号处理方法
属性值发生改变对应的信号处理方法为:on<Propertyname>Changed:
*/

/*
Rectangle { //底层(父项)
    id:bottomLayer
     color: "yellow"
     width: 400; height: 300
     //opacity: 0.8
     MouseArea {
         anchors.fill: parent
         onClicked: console.log("clicked yellow")
         onPressed: console.log("yellow pressed")
     }

    Text{
        anchors.centerIn: parent
        text:topLayerText.text
    }

     Rectangle {  //顶层(子项)
         id: topLayer
         color: "blue"
         width: 300; height: 200
         opacity: 0.5

         ToolTip{
            text: topLayerText.text
         }
         Text{
            id: topLayerText
            anchors.centerIn: parent
            color: "black"
            font{bold: true; italic: true}
         }

         MouseArea {
             anchors.fill: parent
             acceptedButtons: Qt.LeftButton | Qt.RightButton //表示可接受的鼠标按钮
             propagateComposedEvents: true
             onClicked: { //click是按下释放才触发事件
                 console.log("clicked blue")
                 mouse.accepted = false
                 //mouse.accepted = true  //接收了鼠标事件 就不能传输下去了
             }
             onPressed:{ //按下就触发事件

                 console.log("blue pressed")
             }
             hoverEnabled: true
             cursorShape: Qt.OpenHandCursor
             onEntered:{
                 console.log("mouseX=",mouseX, "mouseY=",mouseY)
                 //topLayerText.text = qsTr("%1").arg(mouseX)
             }

            onPositionChanged://  topLayerText.text = qsTr("%1,%2").arg(mouseX).arg(mouseY)
             {
                topLayerText.text = qsTr("%1,%2").arg(mouse.x).arg(mouse.y)
            }

           // onMouseXChanged:  topLayerText.text = qsTr("%1,%2").arg(mouseX).arg(mouseY)
         }
     }
 }
*/

/*
//鼠标拖动事件
Rectangle {
      id: container
      width: 600; height: 200

      Rectangle {
          id: rect
          width: 50; height: 50
          color: "red"
          opacity: (600.0 - rect.x) / 600

          MouseArea {
              anchors.fill: parent
              drag.target: rect //拖动的目标,表示要拖动的是这个rect
              drag.axis: Drag.XAxis | Drag.YAxis
              drag.minimumX: 0
              drag.maximumX: container.width - rect.width
          }
      }
  }
*/

Rectangle {
      width: 480
      height: 320
      Rectangle { //父代
          id:middleRect
          x: 30; y: 30
          width: 300; height: 240
          anchors.left: parent.left  //针对拖动方向X,当左右锚设置时，左右方向拖动就无效.
          anchors.right: parent.right
          color: "lightsteelblue"

          MouseArea {
              anchors.fill: parent
              drag.target: parent;
              drag.axis: "XAxis"  //
              drag.minimumX: 30
              drag.maximumX: 150
               //表示使得父项能够得到响应,当子项的MouseArea覆盖掉
              //父项的MouseArea区域时,使过滤掉子项的MouseArea的响应
              //因为一般子项在父项的上面,子项的MouseArea会优先得到响应
              //此属性为true表示直接过滤掉子项的响应.用于父项控制子项是否接收到鼠标事件.
              //drag.filterChildren: true
              drag.smoothed: false

              //当设置了左右锚后,无法拖动左右的情况下，
              //可以在press下设置锚为undefined,这样
              //左右就可以拖动了.
              onPressed: {
                  console.log("pressed")
                  middleRect.anchors.left = undefined
                  middleRect.anchors.right = undefined
              }
              Rectangle { //子代  //MouseArea下面再包含Item项
                  color: "yellow"
                  x: 50; y : 50
                  width: 100; height: 100
                  MouseArea {
                      anchors.fill: parent
                      onClicked: console.log("child Clicked")
                  }
              }
          }
      }
  }
