const express = require("express");
const { Product } = require("../models/product");
const auth = require("../middlewares/auth_middleware.js");
const productRouter = express.Router();

productRouter.get("/api/products/", auth, async(req,res) => {
    console.log(req.query.category);
    console.log(req.body);
    try {
    const { category } = req.query;
    if (!category) {
      return res.status(400).json({ error: "Missing 'category' query param" });
    }

    const products = await Product.find({ category });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
})

module.exports = productRouter;