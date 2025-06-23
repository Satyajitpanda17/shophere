const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");

const PORT = 3000;
const app = express();

const DB = "mongodb+srv://Satyajit:ShopHere%402025@shophere.l8snym3.mongodb.net/?retryWrites=true&w=majority&appName=ShopHere";

// middleware
app.use(express.json());
app.use(authRouter);

// DB connection
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection success");
  })
  .catch((e) => {
    console.error("Connection failed!!", e);
  });

// start server
app.listen(3000, '0.0.0.0', () => console.log("Server running"));

