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
    #swagger.parameters['name'] = { 
        in: 'body', 
        type: 'int', 
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
})

// Updates the specified pet of the requesting owner
router.put('/pets/:id', checkIfAuthenticated, async (req, res) => {
    const { id } = req.params
    answer = await updatePet(id, req.body.name, req.body.image, req.body.type, req.body.gender, req.body.race, req.body.description, req.body.birthday, req.authId)
    res.status(200).send(answer)
})

// Creates a new belonging to the requesting owner
router.post('/pets', checkIfAuthenticated, async (req, res) => {
    answer = await createPet(req.body.name, req.body.image, req.body.type, req.body.gender, req.body.race, req.body.description, req.body.birthday, req.authId)
    res.status(200).send(answer)
})

// Deletes the specified pet of the requesting owner
router.delete('/pets/:id', checkIfAuthenticated, async (req, res) => {
    const { id } = req.params
    answer = await deletePet(id, req.authId)
    res.status(200).send(answer)
})




// =================
// MATCH ENDPOINTS
// =================

// Returns the requested match
router.get('/match/:id', checkIfAuthenticated, async (req, res) => {
    const { id } = req.params
    match = await getMatchById(id)
    res.status(200).send(match)
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
})

// Updates the specified match as long as the requesting owner is the owner of one of the two pets
router.put('/match/:id', checkIfAuthenticated, async (req, res) => {
    const { id } = req.params
    match = await updateMatchById(req.authId, id, req.body.swiperId, req.body.swipeeId, req.body.request, req.body.answer, req.body.matchDate)
    res.status(200).send(match)
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