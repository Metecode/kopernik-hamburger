const Pool = require("pg").Pool;

const pool = new Pool({
    user: "postgres",
    host: "localhost",
    database:"hamburger",
    password: "mete091234",
    port: 5432,
});

module.exports = pool;
