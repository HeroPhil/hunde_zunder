const { checkIfAuthenticated } = require('./auth')
const { Router } = require('express')
const { sampleQuery2, getMyPets, createPet, updatePet, deletePet, getOpenMatches, getPotentialMatches, getPotentialPets, createMatch, getPetById, getMatchById } = require('./database')

const router = Router()


// =================
// DEBUG ENDPOINTS
// =================

router.get('/', (req, res) => {
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

router.get('/me', checkIfAuthenticated, (req, res) => {
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

router.get('/db2/:id', async (req, res) => {
    const { id } = req.params
    x = await sampleQuery2(id)
    res.status(200).send(x)

    /* 
    ### Swagger Documentation
    #swagger.tags = ["test"] 
    #swagger.description = 'This is a test endpoint to receive sample entries from our test database.'
    #swagger.parameters['id'] = { 
        in: 'body', 
        type: 'string', 
        description: 'The id of the requested sample entry.' 
    }
    #swagger.responses[200] = { 
        description: "The sample with this entry id was found. The whole entry is displayed to you.", 
    } 
    */
})


// =================
// PET ENDPOINTS
// =================

// Return pets under the requesting Owner
router.get('/pets', checkIfAuthenticated, async (req, res) => {
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
router.get('/pets/:id', checkIfAuthenticated, async (req, res) => {
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
router.put('/pets/:id', checkIfAuthenticated, async (req, res) => {
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
router.post('/pets', checkIfAuthenticated, async (req, res) => {
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
router.delete('/pets/:id', checkIfAuthenticated, async (req, res) => {
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




// =================
// MATCH ENDPOINTS
// =================

// Returns the requested match
router.get('/match/:id', checkIfAuthenticated, async (req, res) => {
    const { id } = req.params
    match = await getMatchById(id)
    res.status(200).send(match)

    /* 
    ### Swagger Documentation
    #swagger.tags = ["match"] 
    #swagger.description = 'Endpoint to get all data points about the requested match.'
    #swagger.security = [{
            "bearerAuth": []
        }]
    #swagger.parameters['id'] = { 
        in: 'body', 
        type: 'string', 
        description: 'The id of the match entry.' 
    }
    #swagger.responses[200] = { 
        description: "Your match was found in the database and is displayed to you.", 
    }    
    */
})

// Returns matches for swiping
// Priority: started but not completed matches -> matches were the pet has been swiped -> new matches
// New matches -> up to five new matches are created
router.get('/matches/:petId', checkIfAuthenticated, async (req, res) => {
    const { petId } = req.params
    ownerId = req.authId
    pet = await getPetById(petId)
    console.log(pet)
    if (pet[0]["ownerID"] != ownerId) {
        res.status(403).send("Prohibited! You are not the owner of this pet.")
        return
    }
    matches = await getNewMatches(petId, ownerId)
    res.status(200).send(matches)

    /* 
    ### Swagger Documentation
    #swagger.tags = ["match"] 
    #swagger.description = 'Endpoint to get matches for swiping.'
    #swagger.security = [{
            "bearerAuth": []
        }]
    #swagger.parameters['petId'] = { 
        in: 'body', 
        type: 'string', 
        description: 'The id of the pet you want open matches for.' 
    }
    #swagger.responses[200] = { 
        description: "An open match was found in the database and is displayed to you.", 
    }    
    */
})

// Updates the specified match as long as the requesting owner is the owner of one of the two pets
router.put('/match/:id', checkIfAuthenticated, async (req, res) => {
    const { id } = req.params
    match = await updateMatchById(req.authId, id, req.body.swiperId, req.body.swipeeId, req.body.request, req.body.answer, req.body.matchDate)
    res.status(200).send(match)

    /* 
    ### Swagger Documentation
    #swagger.tags = ["match"] 
    #swagger.description = 'Endpoint to update matches.'
    #swagger.security = [{
            "bearerAuth": []
        }]
    #swagger.parameters['id'] = { 
        in: 'body', 
        type: 'string', 
        description: 'The id of the match you want to update.' 
    }
    #swagger.parameters['swiperId'] = { 
        in: 'body', 
        type: 'string', 
        description: 'The id of the swiper.' 
    }
    #swagger.parameters['swipeeId'] = { 
        in: 'body', 
        type: 'string', 
        description: 'The id of the swipee.' 
    }
    #swagger.parameters['request'] = { 
        in: 'body', 
        type: 'boolean', 
        description: 'Set the new request value.' 
    }
    #swagger.parameters['answer'] = { 
        in: 'body', 
        type: 'boolean', 
        description: 'Set the new answer value.' 
    }
    #swagger.parameters['matchDate'] = { 
        in: 'body', 
        type: 'string', 
        description: 'Set the date when the match is closed.' 
    }
    #swagger.responses[200] = { 
        description: "The match was successfully updated.", 
    }    
    */
})




// =================
// SUPPORT METHODS
// =================

// Support method realizing the priority of match selection for swiping
// Used in: '/matches/:petId'
const getNewMatches = async (petId, ownerId) => {
    matches = await getOpenMatches(petId)
    console.log("Open Matches")
    console.log(matches);

    if (matches.length <= 0) {
        pets = await getPotentialPets(ownerId, petId)
        console.log("Pot Pets")
        console.log(pets);

        if (pets.length <= 0) {
            console.log("No Pets found");
            return matches
        }
        console.log("Creating Matches times: " + pets.size);
        await Promise.all(
            pets.map((pet) => {
                swipeeId = pet["petID"]
                return createMatch(petId, swipeeId)
            }));
        return getNewMatches(petId, ownerId)
    }
    console.log("returning matches");
    console.log(matches);
    return matches
}






module.exports = router