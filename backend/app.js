const { EnvironmentCredentials } = require('aws-sdk')
const express = require('express')
const cors = require('cors')

const app = express()
const PORT = process.env.PORT

// app.use(express.json())

// const swaggerAutogen = require("swagger-autogen")();
// const outputFile = "./swagger-output.json";
// const endpointsFiles = ["./controller/petController.js", "./controller/matchController.js", "./controller/chatController.js"];
// const config = {
//     securityDefinitions: {
//         bearerAuth: {
//             type: 'http',
//             scheme: 'bearer',
//             bearerFormat: 'JWT'
//         }
//     }
// };
// swaggerAutogen(outputFile, endpointsFiles, config).then(
//     async() => {
//         await
//         import ('./app.js');
//     });

app.use(express.json({ limit: '50mb' }));
app.use(express.urlencoded({ limit: '50mb', extended: true, parameterLimit: 50000 }));


app.use(cors({ credentials: true, origin: true }))

// const swaggerUi = require('swagger-ui-express');
// const swaggerDocument = require('./swagger-output.json');
// app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));

const debugController = require('./controller/debugController')
app.use('/', debugController)

const petController = require('./controller/petController')
app.use('/pets', petController)

const matchController = require('./controller/matchController')
app.use('/match', matchController)

const chatController = require('./controller/chatController')
app.use('/chat', chatController)

app.listen(
    PORT,
    () => console.log(`ITS ALIVE on ${PORT}`)
)