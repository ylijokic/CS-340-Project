module.exports = function () {
    var express = require('express');
    var router = express.Router();

    function getBar(res, mysql, context, complete) {
        mysql.pool.query("SELECT id as id, name FROM Bar",
            function (error, results, fields) {
                if (error) {
                    res.write(JSON.stringify(error));
                    res.end();
                }
                context.bar = results;
                complete();
            });
    }

    function getTeam(res, mysql, context, complete) {
        mysql.pool.query("SELECT Team.id as id, team_name, Bar.name AS home_bar FROM Team INNER JOIN Bar ON home_team = Bar.id",
            function (error, results, fields) {
                if (error) {
                    res.write(JSON.stringify(error));
                    res.end();
                }
                context.team = results;
                complete();
            });
    }

    router.get('/', function (req, res) {
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["deleteteam.js", "filterteam.js", "searchteam.js"];
        var mysql = req.app.get('mysql');
        getTeam(res, mysql, context, complete);
        getBar(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 2) {
                res.render('team', context);
            }

        }
    });

    router.post('/', function (req, res) {
        console.log(req.body.bar)
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO Team (team_name, home_bar) VALUES (?,?)";
        var inserts = [req.body.team_name, req.body.home_bar];
        sql = mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            } else {
                res.redirect('/team');
            }
        });
    });
    return router;
}();