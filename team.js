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

    function getSingleTeam(res, mysql, context, id, complete) {
        var sql = "SELECT id AS id, team_name, home_bar_id FROM Team WHERE id = ?";
        var inserts = [id];
        mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            }
            context.team = results[0];
            complete();
        });
    }

    router.get('/', function (req, res) {
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["deleteteam.js", "filterteam.js", "searchteam.js"];
        var mysql = req.app.get('mysql');
        getTeams(res, mysql, context, complete);
        getBars(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 2) {
                res.render('team', context);
            }
        }
    });

    router.get('/:id', function (req, res) {
        callbackCount = 0;
        var context = {};
        context.jsscripts = ["selectedBar.js", "updateTeam.js"];
        var mysql = req.app.get('mysql');
        getSingleTeam(res, mysql, context, req.params.id, complete);
        getBars(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 2) {
                res.render('update_team', context);
            }

        }
    });


    router.post('/', function (req, res) {
        console.log(req.body.bar)
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO Team (team_name, home_bar_id) VALUES (?,?)";
        var inserts = [req.body.team_name, req.body.home_bar_id];
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

    router.put('/:id', function (req, res) {
        var mysql = req.app.get('mysql');
        console.log(req.body)
        console.log(req.params.id)
        var sql = "UPDATE Team SET team_name=?, home_bar_id=? WHERE id=?";
        var inserts = [req.body.team_name, req.body.home_bar_id, req.params.id];
        sql = mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                console.log(error)
                res.write(JSON.stringify(error));
                res.end();
            } else {
                res.status(200);
                res.end();
            }
        });
    });

    router.delete('/:id', function (req, res) {
        var mysql = req.app.get('mysql');
        var sql = "DELETE FROM Team WHERE id=?";
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