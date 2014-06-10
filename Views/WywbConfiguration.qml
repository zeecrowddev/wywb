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
import QtQuick.Controls 1.2

import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Dialogs 1.1


import ZcClient 1.0

ZcAppConfigurationView
{
    width: 600
    height: 480

    id : mainViewConfig

    // Labels
    Column
    {
        id                  : columnLabelId
        width               : parent.width / 4
        anchors.top         : parent.top
        anchors.topMargin   : 60
        anchors.left        : parent.left
        spacing             : 5

        Label
        {
            font.pixelSize  : 24
            height:         30
            anchors.right   : columnLabelId.right
            color           : "white"
            text            : "Start date "
        }

        Label
        {
            font.pixelSize  : 24
            height:         30
            anchors.right   : columnLabelId.right
            color           : "white"
            text            : "End date "
        }

        Label
        {
            font.pixelSize  : 24
            height:         30
            anchors.right   : columnLabelId.right
            color           : "white"
            text            : "Description "
        }
    }

    Button
    {
        id                  : okId

        anchors.top         : columnLabelId.top
        anchors.topMargin   : 0
        anchors.left        : columnValuesId.right
        anchors.leftMargin  : 20

        text                : "ok"

        onClicked   :
        {
            mainViewConfig.dataFormConfiguration.setFieldValue("StartDate",startDate.currentDay + "/" + startDate.currentMonth  + "/" + startDate.currentYear);
            mainViewConfig.dataFormConfiguration.setFieldValue("EndDate",endDate.currentDay + "/" + endDate.currentMonth  + "/" + endDate.currentYear);
            mainViewConfig.dataFormConfiguration.setFieldValue("Description",description.text);
            mainViewConfig.ok();
        }
    }

    // Edits
    Column
    {
        id                  : columnValuesId
        anchors.top         : columnLabelId.top
        anchors.left        : columnLabelId.right
        anchors.leftMargin  : 10
        width               : 240
        spacing             : 5


        WDaySelector
        {
            id : startDate

            focus            : true
            anchors.right       : parent.right
            anchors.left        : parent.left

            calendarContainer: mainViewConfig

            height:         30

        }


        WDaySelector
        {
            id : endDate

            focus            : true
            anchors.right       : parent.right
            anchors.left        : parent.left

            calendarContainer: mainViewConfig

            height:         30
        }
        TextField
        {
            id                  : description

            height:         30
            font.pixelSize  : 24
            anchors.left       : parent.left
            width           : 500
            focus            : true
        }

    }

    onLoaded :
    {
        var startdateText = mainViewConfig.dataFormConfiguration.getFieldValue("StartDate","");
        console.log(">> startdateText " + startdateText)

        if (startdateText !== "")
        {
            var splitsd =  startdateText.split("/");
            startDate.setDate(parseInt(splitsd[2]),parseInt(splitsd[1]),parseInt(splitsd[0]),0)
        }
        else
        {

            startDate.setDate(Date.now().getFullYear(),Date.now().getMonth(),Date.now().getDay(),0)
        }

        var enddateText = mainViewConfig.dataFormConfiguration.getFieldValue("EndDate","");

        console.log(">> enddateText " + enddateText)

        if (enddateText !== "")
        {
            var splited =  enddateText.split("/");
            endDate.setDate(parseInt(splited[2]),parseInt(splited[1]),parseInt(splited[0]),0)
        }
        else
        {
            endDate.setDate(Date.now().getFullYear(),Date.now().getMonth(),Date.now().getDay(),0)
        }

        description.text = mainViewConfig.dataFormConfiguration.getFieldValue("Description","")
    }
}
