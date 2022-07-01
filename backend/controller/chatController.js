const { checkIfAuthenticated } = require('../services/auth')
const { Router } = require('express')
const { getPetById, getSuccessfullMatches, getMatchById, getChatMessages, postMessages } = require('../services/database')

const chatRouter = Router()

// =================
// CHAT ENDPOINTS
// =================

chatRouter.get('/all/:petId', checkIfAuthenticated, async(req, res) => {
    const { petId } = req.params

    // START VALIDATION - Only allow to get chats if the requester is the owner of the pet
    ownerId = req.authId
    pet = await getPetById(petId)
    console.log(pet)
    if (pet[0]["ownerID"] != ownerId) {
        res.status(403).send("Prohibited! You are not the owner of this pet.")
        return
    }
    // END VALIDATION

    chats = await getSuccessfullMatches(petId)
    res.status(200).send(chats)
})



chatRouter.get('/:matchId', checkIfAuthenticated, async(req, res) => {
    const { matchId } = req.params

    // START VALIDATION - Only allow to get messages if the requester is the owner of one of the pets
    ownerId = req.authId
    match = await getMatchById(matchId)
    pet1 = await getPetById(match[0]["swiperID"])
    pet2 = await getPetById(match[0]["swipeeID"])
    if (pet1[0]["ownerID"] != ownerId && pet2[0]["ownerID"] != ownerId) {
        res.status(403).send("Prohibited! You are not the owner of any pet in this chat.")
        return
    }
    // END VALIDATION

    chats = await getChatMessages(matchId)
    res.status(200).send(chats)
})



chatRouter.post('/:matchId', checkIfAuthenticated, async(req, res) => {
    const { matchId } = req.params

    // START VALIDATION - Only allow to post a message if the requester is the owner of one of the pets 
    ownerId = req.authId
    match = await getMatchById(matchId)
    pet1 = await getPetById(match[0]["swiperID"])
    pet2 = await getPetById(match[0]["swipeeID"])
    if (pet1[0]["ownerID"] != ownerId && pet2[0]["ownerID"] != ownerId) {
        res.status(403).send("Prohibited! You are not the owner of any pet in this chat.")
        return
    }
    // END VALIDATION

    timestamp = new Date().toISOString().slice(0, 19).replace('T', ' ')
    answer = await postMessages(matchId, req.body.senderId, req.body.message, timestamp)
    res.status(200).send(answer)
})

module.exports = chatRouter