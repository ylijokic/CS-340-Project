module.exports = function () {
    var express = require('express');
    var router = express.Router();

    function getBars(res, mysql, context, complete) {
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

    function getTeams(res, mysql, context, complete) {
        mysql.pool.query("SELECT Team.id, team_name, Bar.name AS home_bar_name FROM Team INNER JOIN Bar ON home_bar_id = Bar.id",
            function (error, results, fields) {
                if (error) {
                    res.write(JSON.stringify(error));
                    res.end();
                }
                context.teams = results;
                complete();
            });
    }


    function getMatches(res, mysql, context, complete) {
        mysql.pool.query("SELECT Match.id, match_date, Bar.name AS location_name FROM `Match` INNER JOIN `Bar` ON location_id = Bar.id",
            function (error, results, fields) {
                if (error) {
                    res.write(JSON.stringify(error));
                    res.end();
                }
                context.matches = results;
                complete();
            });
    }


    router.get('/', function (req, res) {
        var callbackCount = 0;
        var context = {};
        // context.jsscripts = ["filterMatch.js", "searchMatch.js"];
        var mysql = req.app.get('mysql');
        getMatches(res, mysql, context, complete);
        getBars(res, mysql, context, complete);
        getTeams(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 3) {
                res.render('match', context);
            }
        }
    });

    router.post('/', function (req, res) {
        console.log(req.body.bar)
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO `Match` (match_date, location_id) VALUES (?,?)";
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

    router.delete('/:id', function (req, res) {
        var mysql = req.app.get('mysql');
        var sql = "DELETE FROM `Match` WHERE id=?";
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