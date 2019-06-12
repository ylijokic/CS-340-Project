module.exports = function () {
    var express = require('express');
    var router = express.Router();

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



    router.get('/', function (req, res) {
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["deleteMachine.js", "filterMachine.js", "searchMachine.js"];
        var mysql = req.app.get('mysql');
        getMachines(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 1) {
                res.render('machine', context);
            }

        }
    });

    router.post('/', function (req, res) {
        console.log(req.body.bar)
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO Machine (mach_name, mach_name_short) VALUES (?,?)";
        var inserts = [req.body.mach_name, req.body.mach_name_short];
        sql = mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            } else {
                res.redirect('/machine');
            }
        });
    });

    router.delete('/:id', function (req, res) {
        var mysql = req.app.get('mysql');
        var sql = "DELETE FROM Machine WHERE id=?";
        var inserts = [req.params.id];
        sql = mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                console.log(error)
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