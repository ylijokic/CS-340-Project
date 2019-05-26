module.exports = function () {
    var express = require('express');
    var router = express.Router();

    function getBar(res, mysql, context, complete) {
        mysql.pool.query("SELECT id, name, street_addr, city, state FROM Bar",
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
        mysql.pool.query("SELECT id, mach_name, mach_name_short FROM Machine",
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
        sql = "SELECT bar_id, machine_id, CONCAT name AS name, mach_name AS machine FROM Bar INNER JOIN Machine_Bar on Bar.id = Machine_Bar.bar_id INNER JOIN Machine on Machine.id = Machine_Bar.machine_id ORDER BY name, machine"
        mysql.pool.query(sql, function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end()
            }
            context.people_with_certs = results
            complete();
        });
    }

    router.get('/', function (req, res) {
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["deleteBar.js"];
        var mysql = req.app.get('mysql');
        var handlebars_file = 'machine_bar';

        getBar(res, mysql, context, complete);
        getMachines(res, mysql, context, complete);
        getMachineBars(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 3) {
                res.render(handlebars_file, context);
            }

        }
    });

    //Need to work on this POST request more
    router.post('/', function (req, res) {
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO Bar (name, street_addr, city, state) VALUES (?,?,?,?)";
        var inserts = [req.body.name, req.body.street_addr, req.body.city, req.body.state];
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

    router.delete('/bar_id/:bar_id/machine_id/:machine_id', function (req, res) {

        console.log(req.params.bar_id)
        console.log(req.params.machine_id)
        var mysql = req.app.get('mysql');
        var sql = "DELETE FROM Machine_Bar WHERE bar_id = ? AND machine_id = ?";
        var inserts = [req.params.bar_id, req.params.machine_id];
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