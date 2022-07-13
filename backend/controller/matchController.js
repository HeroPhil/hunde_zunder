const { checkIfAuthenticated } = require('../services/auth')
const { Router } = require('express')
const { getOpenMatches, getPotentialPets, createMatch, getPetById, getMatchById, updateMatchById } = require('../services/database')

const matchRouter = Router()

// =================
// MATCH ENDPOINTS
// =================

// Returns the requested match
matchRouter.get('/:id', checkIfAuthenticated, async (req, res) => {
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
matchRouter.get('/new/:petId', checkIfAuthenticated, async (req, res) => {
    const { petId } = req.params

    // START VALIDATION - Only allow to get new matches if the requester is the owner of the pets
    ownerId = req.authId
    pet = await getPetById(petId)
    console.log(pet)
    if (pet[0]["ownerID"] != ownerId) {
        res.status(403).send("Prohibited! You are not the owner of this pet.")
        return
    }
    // END VALIDATION

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
matchRouter.put('/:id', checkIfAuthenticated, async (req, res) => {
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

module.exports = matchRouter