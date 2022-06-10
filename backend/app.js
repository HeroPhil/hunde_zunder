const { EnvironmentCredentials } = require('aws-sdk')
const express = require('express')
const cors = require('cors')
const user = require('./controller')

const app = express()
const PORT = process.env.PORT

// app.use(express.json())

app.use(express.json({limit: '50mb'}));
app.use(express.urlencoded({limit: '50mb', extended: true, parameterLimit: 50000}));


app.use(cors({credentials: true, origin: true}))


app.use('/', user)

app.listen(
    PORT,
    () => console.log(`ITS ALIVE on ${PORT}`)
)