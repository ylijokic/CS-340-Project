module.exports = function () {
    var express = require('express');
    var router = express.Router();

    function getBar(res, mysql, context, complete) {
        mysql.pool.query("SELECT id AS bar_id, name, street_addr, city, state FROM Bar",
            function (error, results, fields) {
                if (error) {
                    res.write(JSON.stringify(error));
                    res.end();
                }
                context.bar = results;
                complete();
            });
    }

    function getMachines(res, mysql, context, complete) {
        mysql.pool.query("SELECT id AS machine_id, mach_name, mach_name_short FROM Machine",
            function (error, results, fields) {
                if (error) {
                    res.write(JSON.stringify(error));
                    res.end();
                }
                context.machine = results;
                complete();
            });
    }


    //This SQL Query in this function is wrong and will cause an error
    function getMachineBars(res, mysql, context, complete) {
        sql = "SELECT Machine.id, mach_name, Bar.id, Bar.name AS bar_name FROM Bar INNER JOIN Machine_Bar ON Bar.id = bar_id INNER JOIN Machine ON machine_id = Machine.id ORDER BY mach_name ASC;";
        mysql.pool.query(sql, function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end()
            }
            context.machine_bar = results
            complete();
        });
    }

    function getMachineBarsByName(req, res, mysql, context, complete) {
        // var query = "SELECT Machine.id, mach_name, Bar.id, Bar.name AS bar_name FROM Bar INNER JOIN Machine_Bar ON Bar.id = bar_id INNER JOIN Machine ON machine_id = Machine.id  WHERE Bar.bar_name = '?' ORDER BY mach_name ASC;";
        var query = "SELECT Machine.id, mach_name FROM Machine INNER JOIN Machine_Bar ON Machine.id = machine_id INNER JOIN Bar ON bar_id = Bar.id WHERE Bar.id=?;"
        console.log(req.params)
        var inserts = [req.params.bar_id]
        mysql.pool.query(query, inserts, function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            }
            context.machine_bar = results;
            complete();
        });
    }

    router.get('/', function (req, res) {
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["filterMachine_Bar.js"];
        var mysql = req.app.get('mysql');

        getBar(res, mysql, context, complete);
        getMachines(res, mysql, context, complete);
        getMachineBars(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 3) {
                res.render('machine_bar', context);
            }

        }
    });

    router.get('/filter/:bar_id', function (req, res) {
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["deleteMachine_Bar.js", "filterMachine_Bar.js"];
        var mysql = req.app.get('mysql');
        getMachineBarsByName(req, res, mysql, context, complete);
        getMachines(res, mysql, context, complete);
        getMachineBars(res, mysql, context, complete);
        getBar(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 4) {
                res.render('machine_bar', context);
            }
        }
    });



    router.post('/', function (req, res) {
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO Machine_Bar (machine_id, bar_id) VALUES (?,?)";
        var inserts = [req.body.machine_id, req.body.bar_id];
        sql = mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            } else {
                res.redirect('/machine_bar');
            }
        });
    });

    router.delete('/machine_id/:machine_id/bar_id/:bar_id', function (req, res) {

        console.log(req.params.machine_id)
        console.log(req.params.bar_id)
        var mysql = req.app.get('mysql');
        var sql = "DELETE FROM Machine_Bar WHERE machine_id =? AND bar_id =?";
        var inserts = [req.params.machine_id, req.params.bar_id];
        sql = mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.status(400);
                res.end();
            } else {
                res.status(202).end();
            }
        })
    })

    return router;
}();