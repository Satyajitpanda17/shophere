const express = require("express");
const cors = require("cors");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");

const PORT = 3000;
const app = express();
app.use(cors());

const DB = "mongodb+srv://Satyajit:ShopHere%402025@shophere.l8snym3.mongodb.net/?retryWrites=true&w=majority&appName=ShopHere";

// middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

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
app.listen(PORT, '0.0.0.0', () => console.log("Server running on port 3000"));

