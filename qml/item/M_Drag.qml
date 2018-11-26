import QtQuick 2.0

/*
  DragEvent:拖动事件
hasColor,hasHtml,hasText,hasUrls,判断拖动项里面是否包含的数据项,通过属性colorData,html,text,urls
获取具体的数据项的数据.
accepted: 设置是否接收处理事件.
action: 设置对接收拖动事件的项，所要执行的动作.
{
    Qt.CopyAction Copy the data to the target. //表示将数据拷贝到目标
    Qt.MoveAction Move the data from the source to the target. //移动数据到目标
    Qt.LinkAction Create a link from the source to the target. //创建与目标直接的链接
    Qt.IgnoreAction Ignore the action (do nothing with the data). //忽略
}
drag.source:拖动事件的原目标
*/
/*
  任何一个项的Drag附加属性的actives设置为True时,那么该项目的任何位置的变动都会产生一个
  拖动事件,并且发送给与项目新位置相交的DropArea.拖动不仅限于鼠标拖动; 任何可以移动项目的
  东西都可以生成拖动事件，包括触摸事件，动画和绑定.
*/
    Item {
        id: m_drag
        width: 300; height: 300
        Rectangle{
            id: rect1
            anchors.fill: parent
            color: "lightgray"
        }

        MouseArea{
            id: parentMouseArea
            anchors.fill: parent
            drag.filterChildren: true
            hoverEnabled: true
            onPositionChanged:{ //只在当前鼠标区域内有效，坐标之类的都是以当前鼠标区域为参考的
                //m_text.text= qsTr("%1,%2").arg(mouse.x).arg(mouse.y)
            }
        }

        Text{
            id: m_text
            anchors.centerIn: parent
            color: "black"
            text: "dd"
        }

        DropArea { //接收拖动的区域
            x: 75; y: 75
            width: 50; height: 50
            Rectangle {
                anchors.fill: parent
                color: "green"
                //containsDrag用于判断DropArea里面是否包含拖动的项目
                visible: parent.containsDrag //当拖动的项位于DropArea内时就显示
            }
            onPositionChanged:{
                //m_text.text = qsTr("%1, %2").arg(parentMouseArea.mouseX).arg(parentMouseArea.mouseY)
                //m_text.text= qsTr("%1,%2").arg(drag.x).arg(drag.y)

            }
        }

        Rectangle {
            id: redRect
            x: 10; y: 10
            width: 30; height: 30
            color: "red"
            focus:true
            //KeyNavigation.left: rect1
            //KeyNavigation.right: rect1

            //设置当前项为活动状态
            Drag.active: dragArea.drag.active //根据是否当前项是否在被拖动来设置
            Drag.hotSpot.x: 20
            Drag.hotSpot.y: 20

            MouseArea {
                id: dragArea
                anchors.fill: parent
                drag.target: parent
                propagateComposedEvents:true
                onPositionChanged:{ //只在当前鼠标区域内有效，坐标之类的都是以当前鼠标区域为参考的
                    //console.log("positon change")
                    //m_text.text = qsTr("%1, %2").arg(mouseX).arg(mouseY)
                    m_text.text= qsTr("%1,%2").arg(mouse.x).arg(mouse.y)
                    //m_text.text= qsTr("%1,%2").arg(Drag.hotSpot.x).arg(Drag.hotSpot.y)
                }
            }
        }
    }
