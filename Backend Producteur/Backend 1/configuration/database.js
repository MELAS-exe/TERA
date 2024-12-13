const { request } = require('express');

const mysql = require('mysql2');



const db = mysql.createPool({
    connectionLimit: 10, // Adjust based on your needs
    host: 'tera-cluster-instance-1.clas6e6iiazg.eu-north-1.rds.amazonaws.com',
    port: 3306,
    user: 'tera',
    password: 'EnsaEpt18',
    database: 'teradatabase',
});

db.getConnection((err, connection) => {
    if (err) {
        console.error('Error getting connection from pool:', err.message);
        return;
    }
    console.log('Database connection pool established.');
    connection.release(); // Return the connection to the pool
});
module.exports = db;