const { EnvironmentCredentials } = require('aws-sdk')
const express = require('express')
const user = require('./controller')

const app = express()
const PORT = process.env.PORT

app.use(express.json())

app.use('/', user)



app.listen(
    PORT,
    () => console.log(`ITS ALIVE on ${PORT}`)
)