const { EnvironmentCredentials } = require('aws-sdk')
const express = require('express')
const cors = require('cors')
const user = require('./controller')

const app = express()
const PORT = process.env.PORT

// app.use(express.json())

const swaggerAutogen = require("swagger-autogen")(); 
const outputFile = "./swagger-output.json"; 
const endpointsFiles = ["./controller.js"]; 
const config = {
    securityDefinitions: {
        bearerAuth: {
            type: 'http',
            scheme: 'bearer',
            bearerFormat: 'JWT'
        }
    }
};
swaggerAutogen(outputFile, endpointsFiles, config).then(
    async () => { await import('./app.js'); 
});

app.use(express.json({limit: '50mb'}));
app.use(express.urlencoded({limit: '50mb', extended: true, parameterLimit: 50000}));


app.use(cors({credentials: true, origin: true}))


app.use('/', user)

app.listen(
    PORT,
    () => console.log(`ITS ALIVE on ${PORT}`)
)