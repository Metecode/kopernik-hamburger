const express = require("express");
const cors = require('cors');
const hamburgerRoutes = require("./src/hamburger/routes");

const app = express();
const port = 3000;

app.use(express.json());
app.use(cors());

app.get("/", (req, res) => {
  res.send("hello world!");
});

app.use(hamburgerRoutes);

app.listen(port, () => console.log(`app listening on port ${port}`));