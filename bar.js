module.exports = function () {
    var express = require('express');
    var router = express.Router();

    function getBars(res, mysql, context, complete) {
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

    function getSingleBar(res, mysql, context, id, complete) {
        var sql = "SELECT id AS id, name, street_addr, city, state FROM Bar WHERE id = ?";
        var inserts = [id];
        mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            }
            context.bar = results[0];
            complete();
        });
    }

    function getBarsByCity(req, res, mysql, context, complete) {
        var query = "SELECT Bar.id, Bar.name, city, state FROM Bar WHERE city =?";
        console.log(req.params)
        var inserts = [req.params.city]
        mysql.pool.query(query, inserts, function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            }
            context.bar = results;
            complete();
        });
    }

    function getBarsWithCityName(req, res, mysql, context, complete) {
        //sanitize the input as well as include the % character
        var query = `SELECT Bar.id, Bar.name, Bar.street_addr, Bar.city, Bar.state FROM Bar WHERE Bar.city LIKE ` + mysql.pool.escape(req.params.s + '%');

        console.log(query);
        mysql.pool.query(query, function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            }
            context.bar = results;
            complete();
        });
    }

    router.get('/', function (req, res) {
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["deleteBar.js, searchBars.js"];
        var mysql = req.app.get('mysql');
        getBars(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 1) {
                res.render('bar', context);
            }

        }
    });

    router.get('/:id', function (req, res) {
        callbackCount = 0;
        var context = {};
        context.jsscripts = ["updateBar.js"];
        var mysql = req.app.get('mysql');
        getSingleBar(res, mysql, context, req.params.id, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 1) {
                res.render('update_bar', context);
            }

        }
    });

    router.get('/filter/:bar', function (req, res) {
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["deleteBar.js", "filterBars.js"];
        var mysql = req.app.get('mysql');
        getBarsByCity(req, res, mysql, context, complete);
        getBars(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 2) {
                res.render('bar', context);
            }

        }
    });

    router.get('/search/:s', function (req, res) {
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["deleteBar.js", "filterBars.js", "searchBars.js"];
        var mysql = req.app.get('mysql');
        getBarsWithCityName(req, res, mysql, context, complete);
        //getBars(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 1) {
                res.render('bar', context);
            }
        }
    });

    router.post('/', function (req, res) {
        console.log(req.body.bar)
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO Bar (name, street_addr, city, state) VALUES (?,?,?,?)";
        var inserts = [req.body.name, req.body.street_addr, req.body.city, req.body.state];
        sql = mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            } else {
                res.redirect('/bar');
            }
        });
    });

    router.put('/:id', function (req, res) {
        var mysql = req.app.get('mysql');
        console.log(req.body)
        console.log(req.params.id)
        var sql = "UPDATE Bar SET name=?, street_addr=?, city=?, state=? WHERE id=?";
        var inserts = [req.body.name, req.body.street_addr, req.body.city, req.body.state, req.params.id];
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
        var sql = "DELETE FROM Bar WHERE id=?";
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