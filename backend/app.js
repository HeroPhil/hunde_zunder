const { EnvironmentCredentials } = require('aws-sdk')
const express = require('express')
const user = require('./controller')

const app = express()
const PORT = process.env.PORT

app.use(express.json())

app.use(function (req, res, next) {

    var allowedDomains = ['http://localhost:3711', 'https://localhost:3711', 'http://pet-connect.karottenkameraden.de', 'https://pet-connect.karottenkameraden.de/'];
    var origin = req.headers.origin;
    if (allowedDomains.indexOf(origin) > -1) {
        res.setHeader('Access-Control-Allow-Origin', origin);
    }

    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type, Accept');
    res.setHeader('Access-Control-Allow-Credentials', true);

    next();
})

app.use('/', user)

app.listen(
    PORT,
    () => console.log(`ITS ALIVE on ${PORT}`)
)