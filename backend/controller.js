const { checkIfAuthenticated } = require('./auth')
const { createUser } = require('./auth')
const { Router } = require('express')
const { getBasic, sampleQuery, sampleQuery2, getMyPets, createPet, updatePet, deletePet } = require('./database')

const router = Router()


// =================
// DEBUG ENDPOINTS
// =================

router.get('/', (req,res)=> { 
    res.status(200).send('Hello World')
})

router.get('/me', checkIfAuthenticated, (req,res) => {
    res.status(200).send(`You are authenticated with authID = ${req.authId}`)
})

router.get('/db2/:id',  async (req,res) => {
    const { id } = req.params
    x = await sampleQuery2(id)
    res.status(200).send(x)
})


// =================
// GET ENDPOINTS
// =================

router.get('/mypets', checkIfAuthenticated, async (req,res) => {
    ownerId = req.authId
    pets = await getMyPets(ownerId)
    res.status(200).send(pets)
})


// =================
// POST ENDPOINTS
// =================

router.post('/mypets', checkIfAuthenticated, async (req,res) => {
    answer = await createPet(req.body.name, req.body.image, req.body.type, req.body.gender, req.body.race, req.body.description, req.body.birthday, req.authId)
    res.status(200).send(answer)
})


// =================
// PUT ENDPOINTS
// =================

router.put('/mypets/:id', checkIfAuthenticated, async (req,res) => {
    const { id } = req.params
    answer = await updatePet(id, req.body.name, req.body.image, req.body.type, req.body.gender, req.body.race, req.body.description, req.body.birthday, req.authId)
    res.status(200).send(answer)
})


// =================
// DELETE ENDPOINTS
// =================

router.delete('/mypets/:id', checkIfAuthenticated, async (req,res) => {
    const { id } = req.params
    answer = await deletePet(id, req.authId)
    res.status(200).send(answer)
})


module.exports = router