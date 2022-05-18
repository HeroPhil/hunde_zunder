const { checkIfAuthenticated } = require('./auth')
const { createUser } = require('./auth')
const { Router } = require('express')
const { getBasic, sampleQuery } = require('./database')

const router = Router()

router.get('/', (req,res)=> { //get method
    res.status(200)
    res.send('Hello World') //send response
})

router.post('/auth/signup', createUser);

router.get('/private', checkIfAuthenticated, (req,res) => {
    res.status(200).send("You are authenticated")
})

router.get('/db',  async (req,res) => {
    try {
        let results = await getBasic();
        console.log("results");
        console.log(results)
        res.status(200).send(results)
    } catch(e) {
        res.status(500).send(e)
    }
})

router.get('/db/:id',  async (req,res) => {
    const { id } = req.params
    try {
        let results = await sampleQuery(id);
        console.log("results");
        console.log(results)
        res.status(200).send(results)
    } catch(e) {
        res.status(500).send(e)
    }
})

module.exports = router