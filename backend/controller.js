const { checkIfAuthenticated } = require('./auth')
const { Router } = require('express')
const { sampleQuery2, getMyPets, createPet, updatePet, deletePet, getOpenMatches, getPotentialMatches, getPotentialPets, createMatch, getPetById, getMatchById } = require('./database')

const router = Router()


// =================
// DEBUG ENDPOINTS
// =================

router.get('/', (req, res) => {
    res.status(200).send('Hello Petty World')
})

router.get('/me', checkIfAuthenticated, (req, res) => {
    res.status(200).send(`You are authenticated with authID = ${req.authId}`)
})

router.get('/db2/:id', async(req, res) => {
    const { id } = req.params
    x = await sampleQuery2(id)
    res.status(200).send(x)
})


// =================
// PET ENDPOINTS
// =================

// Return pets under the requesting Owner
router.get('/pets', checkIfAuthenticated, async(req, res) => {
    ownerId = req.authId
    pets = await getMyPets(ownerId)
    res.status(200).send(pets)
})

// Returns the requested pet
router.get('/pets/:id', checkIfAuthenticated, async(req, res) => {
    const { id } = req.params
    pet = await getPetById(id)
    res.status(200).send(pet)
})

// Updates the specified pet of the requesting owner
router.put('/pets/:id', checkIfAuthenticated, async(req, res) => {
    const { id } = req.params
    answer = await updatePet(id, req.body.name, req.body.image, req.body.type, req.body.gender, req.body.race, req.body.description, req.body.birthday, req.authId)
    res.status(200).send(answer)
})

// Creates a new belonging to the requesting owner
router.post('/pets', checkIfAuthenticated, async(req, res) => {
    answer = await createPet(req.body.name, req.body.image, req.body.type, req.body.gender, req.body.race, req.body.description, req.body.birthday, req.authId)
    res.status(200).send(answer)
})

// Deletes the specified pet of the requesting owner
router.delete('/pets/:id', checkIfAuthenticated, async(req, res) => {
    const { id } = req.params
    answer = await deletePet(id, req.authId)
    res.status(200).send(answer)
})




// =================
// MATCH ENDPOINTS
// =================

// Returns the requested match
router.get('/match/:id', checkIfAuthenticated, async(req, res) => {
    const { id } = req.params
    match = await getMatchById(id)
    res.status(200).send(match)
})

// Returns matches for swiping
// Priority: started but not completed matches -> matches were the pet has been swiped -> new matches
// New matches -> up to five new matches are created
router.get('/matches/:petId', checkIfAuthenticated, async(req, res) => {
    const { petId } = req.params
    ownerId = req.authId
    pet = getPetById(petId)
    if (pet[0]["ownerID"] != ownerId) {
        res.status(403).send("Prohibited")
        return
    }
    matches = getNewMatches(petId, ownerId)
    res.status(200).send(matches)
})

// Updates the specified match as long as the requesting owner is the owner of one of the two pets
router.put('/match/:id', checkIfAuthenticated, async(req, res) => {
    const { id } = req.params
    match = await updateMatchById(id)
    res.status(200).send(match)
})




// =================
// SUPPORT METHODS
// =================

// Support method realizing the priority of match selection for swiping
// Used in: '/matches/:petId'
const getNewMatches = async(petId, ownerId) => {
    matches = await getOpenMatches(petId)
    if (matches.size <= 0) {
        matches = await getPotentialMatches(petId)

        if (matches.size <= 0) {
            pets = await getPotentialPets(ownerId, petId)
            if (pets.size <= 0) {
                return matches
            }
            await Promise.all(
                pets.map((pet) => {
                    swipeeId = pet["petID"]
                    return createMatch(petId, swipeeId)
                }));
            return getNewMatches(petId, ownerId)
        }
    }
    return matches
}






module.exports = router