const { LexModelBuildingService } = require('aws-sdk');
var mysql = require('mysql');

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




// QUERIES

const sampleQuery2 = async (id) => {

    sql = `SELECT * FROM test.samples WHERE idsamples >= ${id}`
    try {
        let result = await dbQuery(sql)
        return result
    } catch (error) {
        
    }
    
}

const getMyPets = async (ownerId) => {
    sql = `SELECT * FROM petConnect.pet WHERE ownerId = '${ownerId}'`
    return await dbQuery(sql)
}

const createPet = async (name, image, type, gender, race, description, birthday, ownerId) => {
    sql = `INSERT INTO petConnect.pet (name, image, type, gender, race, description, birthday, ownerID) VALUES ('${name}', '${image}', '${type}', '${gender}', '${race}', '${description}', '${birthday}', '${ownerId}')`
    return await dbQuery(sql)
}

const updatePet = async (petId, name, image, type, gender, race, description, birthday, ownerId) => {
    sql = `UPDATE petConnect.pet SET name = '${name}', image = '${image}', type = '${type}', gender = '${gender}', race = '${race}', description = '${description}', birthday = '${birthday}' WHERE petID = '${petId}' AND ownerID = '${ownerId}'`
    return await dbQuery(sql)
}

const deletePet = async (petId, ownerId) => {
    sql = `DELETE FROM petConnect.pet WHERE petID = '${petId}' AND ownerID = '${ownerId}'`
    return await dbQuery(sql)
}


exports.sampleQuery2 = sampleQuery2
exports.getMyPets = getMyPets
exports.createPet = createPet
exports.updatePet = updatePet
exports.deletePet = deletePet
