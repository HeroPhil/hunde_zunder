const { checkIfAuthenticated } = require('../services/auth')
const { Router } = require('express')

const debugRouter = Router()

// =================
// DEBUG ENDPOINTS
// =================

debugRouter.get('/', (req, res) => {
    res.status(200).send('Hello Petty World')
        /* 
        ### Swagger Documentation
        #swagger.tags = ["test"] 
        #swagger.description = 'Endpoint to test the connection.'
        #swagger.responses[200] = { 
            description: "Connected successfully to the api.", 
        } 
        */
})

debugRouter.get('/authStatus', checkIfAuthenticated, (req, res) => {
    res.status(200).send(`You are authenticated with authID = ${req.authId}`)
        /* 
        ### Swagger Documentation
        #swagger.tags = ["test"] 
        #swagger.description = 'Endpoint to check what your authentication id is.'
        #swagger.security = [{
                   "bearerAuth": []
            }]
        #swagger.responses[200] = { 
            description: "You are authenticated and your authId is displayed.", 
        } 
        */
})

module.exports = debugRouter