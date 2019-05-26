module.exports = function () {
    var express = require('express');
    var router = express.Router();

    function getMatch(res, mysql, context, complete) {
        mysql.pool.query("SELECT Match.id, match_date, Bar.id AS location_id FROM Match INNER JOIN Bar ON location_id = Bar.id",
            function (error, results, fields) {
                if (error) {
                    res.write(JSON.stringify(error));
                    res.end();
                }
                context.match = results;
                complete();
            });
    }

    router.get('/', function (req, res) {
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["filterMatch.js", "searchMatch.js"];
        var mysql = req.app.get('mysql');
        getMatch(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 1) {
                res.render('match', context);
            }

        }
    });

    router.post('/', function (req, res) {
        console.log(req.body.bar)
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO Match (match_date, location_id) VALUES (?,?)";
        var inserts = [req.body.match_date, req.body.location_id];
        sql = mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            } else {
                res.redirect('/match');
            }
        });
    });
    return router;
}();