/**
* Copyright (c) 2010-2014 "Jabber Bees"
*
* This file is part of the WebApp application for the Zeecrowd platform.
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

.pragma library


function foreachInListModel(listModel, delegate)
{
    for (var i=0;i<listModel.count;i++)
    {
        delegate(listModel.get(i));
    }
}

function existsInArray(array, findDelegate)
{
    for (var i=0;i<array.length;i++)
    {
        if ( findDelegate(array[i]) )
        {
            return true;
        }
    }
    return false;
}

function removeInArray(array, findDelegate)
{
    var index = -1;
    for (var i=0;i<array.length;i++)
    {
        if ( findDelegate(array[i]) )
        {
            index = i;
            break;
        }
    }

    if (index !=-1)
    {
        var result = array[index];
        array.splice(index,1);
        return result;
    }
    return null;
}

function forEachInArray(array, delegate)
{
    for (var i=0;i<array.length;i++)
    {
        delegate(array[i]);
    }
}


function parseDatas(datas)
{
    if (datas === null || datas === undefined)
        return {}


    var objectDatas = null;

    try
    {

        objectDatas = JSON.parse(datas);
    }
    catch (e)
    {
        objectDatas = {}
    }

    if (objectDatas === null)
        return {};

    if (objectDatas === undefined)
        return {};

    objectDatas.testparse = "testparse"
    if (objectDatas.testparse !== "testparse")
    {
        return {}
    }

    objectDatas.testparse = undefined;

    return objectDatas;

}
