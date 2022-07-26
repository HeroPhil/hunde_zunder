const { checkIfAuthenticated } = require('../services/auth')
const { Router } = require('express')
const { getMyPets, createPet, updatePet, deletePet, getPetById } = require('../services/database')

const petRouter = Router()

// =================
// PET ENDPOINTS
// =================

// Return pets under the requesting Owner
petRouter.get('/', checkIfAuthenticated, async(req, res) => {
    ownerId = req.authId
    pets = await getMyPets(ownerId)
    res.status(200).send(pets)

    /* 
    ### Swagger Documentation
    #swagger.tags = ["pets"] 
    #swagger.description = 'Endpoint to get a list of all the pets you registered in the database.'
    #swagger.security = [{
            "bearerAuth": []
        }]
    #swagger.responses[200] = { 
        description: "Your pets were found in the database and are displayed to you.", 
    } 
    */
})

// Returns the requested pet
petRouter.get('/:id', checkIfAuthenticated, async(req, res) => {
    const { id } = req.params
    pet = await getPetById(id)
    res.status(200).send(pet)

    /* 
    ### Swagger Documentation
    #swagger.tags = ["pets"] 
    #swagger.description = 'Endpoint to get all data points about the requested pet.'
    #swagger.security = [{
            "bearerAuth": []
        }]
    #swagger.parameters['id'] = { 
        in: 'body', 
        type: 'string', 
        description: 'The id of the requested pet entry.' 
    }
    #swagger.responses[200] = { 
        description: "Your pet was found in the database and all data points are displayed to you.", 
    }    
    */
})

// Updates the specified pet of the requesting owner
petRouter.put('/:id', checkIfAuthenticated, async(req, res) => {
    const { id } = req.params
    answer = await updatePet(id, req.body.name, req.body.image, req.body.type, req.body.gender, req.body.race, req.body.description, req.body.birthday, req.authId)
    res.status(200).send(answer)

    /* 
    ### Swagger Documentation
    #swagger.tags = ["pets"] 
    #swagger.description = 'Endpoint to update data points of a specific pet.'
    #swagger.security = [{
            "bearerAuth": []
        }]
    #swagger.parameters['id'] = { 
        in: 'body', 
        type: 'string', 
        description: 'The id of the pet entry.' 
    }
    #swagger.parameters['name'] = { 
        in: 'body', 
        type: 'string', 
        description: 'The name of the pet.' 
    }
    #swagger.parameters['image'] = { 
        in: 'body', 
        type: 'image', 
        description: 'The image of the pet.' 
    }
    #swagger.parameters['type'] = { 
        in: 'body', 
        type: 'string', 
        description: 'The pet type of the pet.' 
    }
    , req.body., req.body., req.body.birthday
    #swagger.parameters['gender'] = { 
        in: 'body', 
        type: 'string', 
        description: 'The gender of the pet.' 
    }
    #swagger.parameters['race'] = { 
        in: 'body', 
        type: 'string', 
        description: 'The race of the pet.' 
    }
    #swagger.parameters['type'] = { 
        in: 'body', 
        type: 'string', 
        description: 'The type of pet.' 
    }
    #swagger.responses[200] = { 
        description: "Your pet was found in the database and the data points were updated.", 
    }    
    */
})

// Creates a new belonging to the requesting owner
petRouter.post('/', checkIfAuthenticated, async(req, res) => {
    answer = await createPet(req.body.name, req.body.image, req.body.type, req.body.gender, req.body.race, req.body.description, req.body.birthday, req.authId)
    res.status(200).send(answer)

    /* 
    ### Swagger Documentation
    #swagger.tags = ["pets"] 
    #swagger.description = 'Endpoint to create a new pet in the database.'
    #swagger.security = [{
            "bearerAuth": []
        }]
    #swagger.parameters['id'] = { 
        in: 'body', 
        type: 'string', 
        description: 'The id of the pet entry.' 
    }
    #swagger.parameters['name'] = { 
        in: 'body', 
        type: 'string', 
        description: 'The name of the pet.' 
    }
    #swagger.parameters['image'] = { 
        in: 'body', 
        type: 'image', 
        description: 'The image of the pet.' 
    }
    #swagger.parameters['type'] = { 
        in: 'body', 
        type: 'string', 
        description: 'The pet type of the pet.' 
    }
    , req.body., req.body., req.body.birthday
    #swagger.parameters['gender'] = { 
        in: 'body', 
        type: 'string', 
        description: 'The gender of the pet.' 
    }
    #swagger.parameters['race'] = { 
        in: 'body', 
        type: 'string', 
        description: 'The race of the pet.' 
    }
    #swagger.parameters['type'] = { 
        in: 'body', 
        type: 'string', 
        description: 'The type of pet.' 
    }
    #swagger.responses[200] = { 
        description: "Your pet was found in the database and the data points were updated.", 
    }    
    */
})

// Deletes the specified pet of the requesting owner
petRouter.delete('/:id', checkIfAuthenticated, async(req, res) => {
    const { id } = req.params
    answer = await deletePet(id, req.authId)
    res.status(200).send(answer)

    /* 
    ### Swagger Documentation
    #swagger.tags = ["pets"] 
    #swagger.description = 'Endpoint to delte all data points about the pet.'
    #swagger.security = [{
            "bearerAuth": []
        }]
    #swagger.parameters['id'] = { 
        in: 'body', 
        type: 'string', 
        description: 'The id of the pet entry.' 
    }
    #swagger.responses[200] = { 
        description: "Your pet was found and deleted from the database", 
    }    
    */
})

module.exports = petRouter