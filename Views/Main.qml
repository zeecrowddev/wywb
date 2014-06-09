/**
* Copyright (c) 2010-2014 "Jabber Bees"
*
* This file is part of the Wywb application for the Zeecrowd platform.
*
* Zeecrowd is an online collaboration platform [http://www.zeecrowd.com]
*
* WebApp is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
* 
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.2
import QtQuick.Dialogs 1.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1

import ZcClient 1.0 as Zc


import "Main.js" as Presenter
import "Tools.js" as Tools


Zc.AppView
{
    id : mainView

    property string _1 : ""
    property string _2 : ""
    property string _3 : ""
    property string _4 : ""
    property string _5 : ""
    property string _6 : ""
    property string _7 : ""
    property string _8 : ""
    property string _9 : ""
    property string _10 : ""
    property string _11 : ""
    property string _12 : ""
    property string _13 : ""
    property string _14 : ""
    property string _15 : ""
    property string _16 : ""
    property string _17 : ""
    property string _18 : ""
    property string _19 : ""
    property string _20 : ""
    property string _21 : ""
    property string _22 : ""
    property string _23 : ""
    property string _24 : ""
    property string _25 : ""
    property string _26 : ""
    property string _27 : ""
    property string _28 : ""
    property string _29 : ""
    property string _30 : ""
    property string _31 : ""
    property string _32 : ""
    property string _33 : ""
    property string _34 : ""
    property string _35 : ""
    property string _36 : ""
    property string _37 : ""
    property string _38 : ""
    property string _39 : ""
    property string _40 : ""
    property string _41 : ""
    property string _42 : ""

    property string _100 : ""


    toolBarActions :
        [
        Action {
            id: closeAction
            shortcut: "Ctrl+X"
            iconSource: "qrc:/WebApp/Resources/close.png"
            tooltip : "Close Application"
            onTriggered:
            {
                mainView.close();
            }
        }
    ]


    Zc.AppNotification
    {
        id : appNotification
    }

    /*
    ** Clean all external notifications
    ** Set the focus
    */

    onIsCurrentViewChanged :
    {
        if (isCurrentView == true)
        {
            appNotification.resetNotification();
        }
    }

    function days_in_month(month,year) {
        var m = [31,28,31,30,31,30,31,31,30,31,30,31];
        if (month != 2) return m[month - 1]; //tout sauf février
        if (year%4 != 0) return m[1]; //février normal non bissextile
        if (year%100 == 0 && year%400 != 0) return m[1];  //février bissextile siècle non divisible par 400
        return m[1] + 1; //tous les autres févriers = 29 jours
    }


    property int dayOfWeek : 0;
    property int daysInMonth : 0;
    property int currentMonth : 0;


    function clearDayProperties()
    {
        for (var i = 1;i <= 42;i++)
        {
            mainView["_"+ i] = "";
        }

    }

    function calculateParameters()
    {
        clearDayProperties()

        var date = new Date(calendar.visibleYear,calendar.visibleMonth,1,0,0,0,0);
        dayOfWeek = date.getDay();
        if (dayOfWeek === 0)
            dayOfWeek = 7
        else if (dayOfWeek === 1)
            dayOfWeek = 8
        daysInMonth = days_in_month(date.getMonth() + 1,date.getFullYear());
        currentMonth = date.getMonth()
    }


    function generateKey(date)
    {
        return mainView.context.nickname + "|" +
                calendar.selectedDate.getYear() + "|" +
                calendar.selectedDate.getMonth() + "|" +
                calendar.selectedDate.getDate();
    }

    Calendar
    {
        id : calendar
        anchors.fill: parent

        style : CalendarStyle
        {
        dayDelegate:
            Item {
            readonly property color sameMonthDateTextColor: "#444"
            readonly property color selectedDateColor: Qt.platform.os === "osx" ? "#3778d0" : __syspal.highlight
            readonly property color selectedDateTextColor: "white"
            readonly property color differentMonthDateTextColor: "#bbb"
            readonly property color invalidDatecolor: "#dddddd"


//            function backgroundColor()
//            {

//                console.log(">> calculate backcolor of " + selectedDateColor)
//                if (styleData.date !== undefined && styleData.selected)
//                    return selectedDateColor;
//                else
//                    if (mainView["_" + styleData.date.getDate()] !== "")
//                        return "red"
//                    else
//                        return  "transparent"
//            }


            property string dayProperty : calculateDayProperty(styleData.date)


            function calculateBackcolor(value)
            {

                var o = Tools.parseDatas(value)

                var whos = o.who.split("|")

                listWho.model = whos

                if (o.who === "" || o.who === undefined)
                {
                    return "transparent"
                }


                if (Tools.existsInArray(whos, function (x) { return x === mainView.context.nickname}))
                {
                    return "lightblue"
                }

                return "orange"
            }


//            Image
//            {
//                visible: mainView["_" + dayProperty] !== ""
//                anchors.fill: parent
//                source : mainView["_" + dayProperty] !== "" ? activity.getParticipantImageUrl(mainView["_" + dayProperty]) : ""
//            }


            ListView
            {
                id : listWho
                anchors.fill: parent
                delegate : Label { text : modelData }

                interactive: false
            }

            Rectangle {
                id : backColor
                anchors.fill: parent
                border.color: "transparent"
                //color: mainView["_" + calculateDayProperty(styleData.date)] !== "" ? "orange" : "transparent"
                color: calculateBackcolor(mainView["_" + dayProperty])
                anchors.margins: styleData.selected ? -1 : 0
                opacity : 0.3
            }



//            Image {
//                visible: eventModel.eventsForDate(styleData.date).length > 0
//                anchors.top: parent.top
//                anchors.left: parent.left
//                anchors.margins: -1
//                width: 12
//                height: width
//                source: "qrc:/images/eventindicator.png"
//            }

            Label {
                id: dayDelegateText
                text: styleData.date.getDate()
                font.pixelSize: 14
                anchors.centerIn: parent
                color: {
                    var color = invalidDatecolor;
                    if (styleData.valid) {
                        // Date is within the valid range.
                        color = styleData.visibleMonth ? sameMonthDateTextColor : differentMonthDateTextColor;
//                        if (styleData.selected) {
//                            color = selectedDateTextColor;
//                        }
                    }
                    color;
                }
            }
        }
    }


        onClicked:
        {
            var key = generateKey(calendar.selectedDate);

            if (items.getItem(key,"___") === "___")
            {
                items.setItem(key,"",null)
            }
            else
            {
                items.deleteItem(key)
            }
        }

        onVisibleMonthChanged:
        {
            calculateParameters()
        }

        onVisibleYearChanged:
        {
            calculateParameters()
        }
    }


    function calculateDayProperty(date)
    {
        var daydate = date.getDate();
        var month = date.getMonth();
        var year = date.getFullYear();

        var val = 0;
        if (month === mainView.currentMonth)
        {
            return (mainView.dayOfWeek + daydate);
        }
        else if (month === mainView.currentMonth + 1 ||
                     (mainView.currentMonth === 11 && month === 0))
        {
            val = mainView.dayOfWeek + mainView.daysInMonth - 1 + daydate;
            if (val <= 42)
                return val;
        }
        else if (month + 1 === mainView.currentMonth ||
                 (mainView.currentMonth === 0 && month === 11))
        {

            var days = days_in_month(month,year);

            val = mainView.dayOfWeek - (days - daydate);
            if (val >= 1)
                    return val;
        }

        return 100;

    }


    Zc.CrowdActivity
    {
        id : activity

        Zc.CrowdActivityItems
        {
            Zc.QueryStatus
            {
                id : itemQueryStatus

                onCompleted :
                {
                }
            }

            id          : items
            name        : "CalendarItems"
            //persistent  : true

            onItemChanged :
            {
                var split = idItem.split("|");
                var date = new Date(parseInt(split[1]),parseInt(split[2]),parseInt(split[3]),0,0,0);
                var who = split[0]

                var dayProperty = mainView.calculateDayProperty(date);

                var o = Tools.parseDatas(mainView[ "_" + dayProperty]);

                if (o.who === undefined || o.who === "")
                {
                    o.who = who;
                }
                else
                {
                    var whosplit = o.who.split("|");
                    if (!Tools.existsInArray(whosplit,function(x){ return x === who}) )
                    {
                        o.who = o.who + "|" + who;
                    }
                }

                mainView["_" + dayProperty] = JSON.stringify(o)
            }

            onItemDeleted :
            {
                var split = idItem.split("|");
                var date = new Date(parseInt(split[1]),parseInt(split[2]),parseInt(split[3]),0,0,0);
                var who = split[0]

                var dayProperty = mainView.calculateDayProperty(date);

                var o = Tools.parseDatas(mainView[ "_" + dayProperty]);

                if (o.who !== undefined && o.who !== "")
                {
                    if (o.who === who)
                    {
                        o.who = "";
                    }
                    else
                    {
                        var whosplit = o.who.split("|");
                        Tools.removeInArray(whosplit, function (x) { return x === who} )
                        o.who = whosplit.join("|")
                    }
                }

                mainView["_" + dayProperty] = JSON.stringify(o)
            }
        }


        onStarted :
        {
            items.loadItems(itemQueryStatus);
        }

        onContextChanged :
        {
        }
    }




    onLoaded :
    {
        activity.start();
    }

    onClosed :
    {
        activity.stop();
    }
}
