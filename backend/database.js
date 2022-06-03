const { LexModelBuildingService } = require('aws-sdk');
var mysql = require('mysql');


//####################
// CONNECTION
//####################
var connection = mysql.createConnection({
    host: process.env.RDS_HOSTNAME,
    user: process.env.RDS_USERNAME,
    password: process.env.RDS_PASSWORD,
    port: process.env.RDS_PORT
});

connection.connect(function (err) {
    if (err) {
        console.error('Database connection failed: ' + err.stack);
        return;
    }

    console.log('Connected to database.');
});


//####################
// UNIVERSAL QUERY
//####################
const dbQuery = (sqlQuery) => {
    return new Promise((resolve, reject) => {
        connection.query(sqlQuery, function (err, rows) {
            if (err) {
                return reject(err);
            } else {
                return resolve(rows)
            }
        });
    });
}



//####################
// DEBUG QUERIES
//####################
const sampleQuery2 = async (id) => {

    sql = `SELECT * FROM test.samples WHERE idsamples >= ${id}`
    try {
        let result = await dbQuery(sql)
        return result
    } catch (error) {
        
    }
    
}

//####################
// PET ENDPOINTS
//####################

const getMyPets = async (ownerId) => {
    sql = `
    SELECT * 
    FROM petConnect.pet 
    WHERE ownerID = '${ownerId}'
    `
    return await dbQuery(sql)
}

const createPet = async (name, image, type, gender, race, description, birthday, ownerId) => {
    sql = `
    INSERT INTO petConnect.pet (name, image, type, gender, race, description, birthday, ownerID) 
    VALUES ('${name}', '${image}', '${type}', '${gender}', '${race}', '${description}', '${birthday}', '${ownerId}')
    `
    return await dbQuery(sql)
}

const updatePet = async (petId, name, image, type, gender, race, description, birthday, ownerId) => {
    sql = `
    UPDATE petConnect.pet 
    SET name = '${name}', image = '${image}', type = '${type}', gender = '${gender}', race = '${race}', description = '${description}', birthday = '${birthday}' 
    WHERE petID = '${petId}' 
    AND ownerID = '${ownerId}'
    `
    return await dbQuery(sql)
}

const deletePet = async (petId, ownerId) => {
    sql = `
    DELETE 
    FROM petConnect.pet 
    WHERE petID = '${petId}' 
    AND ownerID = '${ownerId}'
    `
    return await dbQuery(sql)
}

const getPetById = async (petId) => {
    sql = `
    SELECT * 
    FROM petConnect.pet 
    WHERE petID = '${petId}'
    `
    return await dbQuery(sql)
}


//####################
// GET SWIPE POTENTIAL
//####################
const getOpenMatches = async (petId) => {
    sql = `
    SELECT * 
    FROM petConnect.match 
    WHERE swiperID = ${petId}
    AND request IS NULL
    AND answer IS NULL
    `
    return await dbQuery(sql)
}

const getPotentialMatches = async (petId) => {
    sql = `
    SELECT * 
    FROM petConnect.match 
    WHERE swipeeID = ${petId}
    AND answer IS NULL
    AND request IS NOT NULL
    `
    return await dbQuery(sql)
}

const getPotentialPets = async (ownerId, petId) => {
    sql = `
    SELECT petID 
    FROM petConnect.pet 
    WHERE ownerID <> ${ownerId}
    AND petID NOT IN 
    (
        SELECT swiperID 
        FROM petConnect.match 
        WHERE swipeeID = ${petId}
    )
    AND petID NOT IN 
    (
        SELECT swipeeID 
        FROM petConnect.match 
        WHERE swiperID = ${petId}
    )
    LIMIT 5
    `
    return await dbQuery(sql)
}


//####################
// MATCHES ENDPOINTS
//####################

const createMatch = async (petId, swipeeID) => {
    sql = `
    INSERT INTO petConnect.match (swiperID, swipeeID) 
    VALUES ('${petId}', '${swipeeID}')
    `
    return await dbQuery(sql)
}

const getMatchById = async (matchId) => {
    sql = `
    SELECT * 
    FROM petConnect.match 
    WHERE matchID = '${matchId}'
    `
    return await dbQuery(sql)
}

const updateMatch = async (ownerId, swiperID, swipeeID, matchID, request, answer, matchDate) => {
    sql = `
    UPDATE petConnect.match 
    SET swiperID = '${swiperID}', swipeeID = '${swipeeID}', matchID = '${matchID}', request = '${request}', answer = '${answer}', matchDate = '${matchDate}' 
    WHERE swiperID = '${swiperID}' 
    AND swipeeID = '${swipeeID}' 
    AND ${ownerId} IN 
    (
        SELECT ownerID
        FROM petConnect.pet
        WHERE petID = '${swiperID}'
        OR petID = '${swipeeID}'
    )
    `
    return await dbQuery(sql)
}


//####################
// EXPORTS
//####################
exports.sampleQuery2 = sampleQuery2
exports.getMyPets = getMyPets
exports.createPet = createPet
exports.updatePet = updatePet
exports.deletePet = deletePet
exports.getOpenMatches = getOpenMatches
exports.getPotentialMatches = getPotentialMatches
exports.getPotentialPets = getPotentialPets
exports.createMatch = createMatch
exports.getPetById = getPetById
exports.getMatchById = getMatchById
exports.updateMatch = updateMatch
