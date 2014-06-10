import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.0

Rectangle
{
    id: root

    color: "transparent"

    property Item calendarContainer : null

    width: 400
    height: 30

    function setDate(year, month, day, offset)
    {


        var myDate = new Date(year, month, day)
        myDate.setDate(myDate.getDate() + parseInt(offset))

        root.currentMonth = myDate.getMonth()
        root.currentDay = myDate.getDate()
        root.currentYear = myDate.getFullYear()

        var displayMonth = root.currentMonth*1+1
        whenInput.text = (displayMonth < 10 ? "0" + displayMonth : displayMonth) + "/" + (root.currentDay < 10 ? "0" + root.currentDay : root.currentDay) + "/" + root.currentYear

        refreshLabel(root.currentYear, root.currentMonth, root.currentDay)
    }

    function refreshLabel(year, month, day)
    {
        var date = new Date(year, month, day)
        //dayHelper.text = Qt.formatDate( date, "dddd MMM d yyyy" )
    }

    property int currentDay;
    property int currentMonth;
    property int currentYear;

    Rectangle
    {
        id: dayPicker
        color: "white"
        border.color: "darkblue"
        smooth:true;
        width:170
        height: root.height

        Image
        {
            id          : leftArrow
            source      : "qrc:/CrowdTools/Resources/left.png"
            width       : 20
            height      : 20
            x           : 0
            y           : 5

            MouseArea
            {
                id : previousDay
                anchors.fill: parent
                onClicked: {
                    var date = new Date(root.currentYear, root.currentMonth, root.currentDay)
                    date.setDate(date.getDate() - 1)
                    root.currentYear = date.getFullYear()
                    root.currentMonth = date.getMonth()
                    root.currentDay = date.getDate()
                    root.setDate(root.currentYear, root.currentMonth, root.currentDay, 0)
                }
            }
        }

        TextInput
        {
            x: 25; y:3
            id: whenInput
            width: root.width
            height:root.height
            font.family: "Arial"
            font.pointSize: 14;
            inputMask:"99/99/9999"

            onTextChanged: {

                //onEditingFinished : {
                var details = whenInput.text.split("/")
                root.currentYear = details[2]
                root.currentMonth = details[0]-1
                root.currentDay = details[1]
                root.refreshLabel(details[2], details[0]-1, details[1])
            }
        }

        Image
        {
            id          : rightArrow
            source      : "qrc:/CrowdTools/Resources/right.png"
            width       : 20
            height      : 20
            x           : dayPicker.width-22
            y           : 5

            MouseArea
            {
                id : nextDay
                anchors.fill: parent
                onClicked: {
                    var date = new Date(root.currentYear, root.currentMonth, root.currentDay)
                    date.setDate(date.getDate() + 1)
                    root.currentYear = date.getFullYear()
                    root.currentMonth = date.getMonth()
                    root.currentDay = date.getDate()
                    root.setDate(root.currentYear, root.currentMonth, root.currentDay, 0)
                }
            }
        }
    }

    Button
    {
        id : dayButton
        height : root.height
        width  : height

        anchors.left : dayPicker.right
        anchors.leftMargin : 5

        anchors.verticalCenter: dayPicker.verticalCenter

        style: ButtonStyle {}

        onClicked:
        {
            calendar.setDate(new Date(root.currentYear, root.currentMonth, root.currentDay))
            calendar.parent = root.calendarContainer
            calendar.anchors.fill = root.calendarContainer
            calendar.visible = true;
        }
    }


    Rectangle
    {

        id      : calendar
        color : "white"

        function setDate(date)
        {
            internalCalendar.selectedDate = date
        }

        visible : false
        Calendar
        {
            id : internalCalendar
             anchors.fill: parent
             style   : CalendarStyle{}

             onDoubleClicked:
             {
                 root.currentYear = date.getFullYear()
                 root.currentMonth = date.getMonth()
                 root.currentDay = date.getDate()
                 root.setDate(root.currentYear, root.currentMonth, root.currentDay, 0)
                 calendar.visible = false;
             }
        }
    }

//    Text
//    {
//        id: dayHelper

//        color : "white"

//        anchors.left : dayButton.right
//        anchors.leftMargin : 5
//        anchors.verticalCenter: dayPicker.verticalCenter

//        font.pointSize:10
//        font.capitalization: Font.AllUppercase
//    }
}
