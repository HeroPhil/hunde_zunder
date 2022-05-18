var mysql = require('mysql');

var connection = mysql.createConnection({
    host: process.env.RDS_HOSTNAME,
    user: process.env.RDS_USERNAME,
    password: process.env.RDS_PASSWORD,
    port: process.env.RDS_PORT
});

connection.connect(function (err) {
    if (err) {
        console.error('Database connection failed: ' + err.stack);
        return;
    }

    console.log('Connected to database.');
});

// "SELECT 1 + 1 AS solution"

const getBasic = () => {
    return new Promise((resolve, reject) => {
        connection.query("SELECT 1 + 1 AS solution", function (err, rows) {
            if (err) {
                return reject(err);
            } else {
                return resolve(rows)
            }
        });
    });
}

const sampleQuery = (id) => {
    return new Promise((resolve, reject) => {
        sql = `SELECT * FROM test.samples WHERE idsamples >= ${id}`
        connection.query(sql, function (err, rows) {
            if (err) {
                return reject(err);
            } else {
                return resolve(rows)
            }
        });
    });
}

exports.getBasic = getBasic
exports.sampleQuery = sampleQuery
