/* -*- coding: utf-8-unix -*-
 *
 * Copyright (C) 2018 Rinigus
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import "."

Item {
    id: wrapper

    property alias ready: py.ready

    Component.onDestruction: console.log("PythonWithWrapper Destruction called")

    Python {
        id: py
    }

    function call(func, args, callback) {
        console.log("Call -> " + func + " " + JSON.stringify(args).substring(0, 60));
        py.call(func, args,
                function a(result) {
                    console.log("Return from call of " + func);
                    if (callback) {
                        callback(result);
                    }
                });
    }

    function evaluate(expr) {
        console.log("Evaluate " + expr);
        var r = py.evaluate(expr);
        console.log("Expression evaluated " + expr);
        return r;
    }

    function call_sync(func, args) {
        console.log("Call_sync -> " + func + " " + JSON.stringify(args).substring(0, 60));
        var r = py.call_sync(func, args);
        console.log("Return from call_sync of " + func);
        return r;
    }
}
