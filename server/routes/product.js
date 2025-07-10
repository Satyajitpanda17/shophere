const express = require("express");
const { Product } = require("../models/product");
const auth = require("../middlewares/auth_middleware.js");
const productRouter = express.Router();

productRouter.get("/api/products/", auth, async(req,res) => {
   // console.log(req.query.category);
    //console.log(req.body);
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

productRouter.get("/api/products/search/:name", auth , async(req,res) => {
    try {
      const products = await  Product.find({
        name : {$regex : req.params.name, $options : "i"},
      });
      console.log(products);
      if(!products){
        return res.status(400).json({error : "No product found of this name"});
      }
      res.status(200).json(products);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
})

productRouter.post("/api/rate-product", auth, async(req,res) => {
  try {
    const {id,rating} = req.body;
    let product = await Product.findById(id);
    if(!product){
      res.status(400).json({error : "No product founf of this Id"});
    }
    for (let i = 0; i < product.ratings.length; i++) {
      if (product.ratings[i].userId == req.user) {
        product.ratings.splice(i, 1);
        break;
      }
    }
     const ratingSchema = {
      userId: req.user,
      rating,
    };

     product.ratings.push(ratingSchema);
    product = await product.save();
    res.json(product);
  } catch (e) {
     res.status(500).json({ error: e.message });
  }
})


productRouter.get("/api/deal-of-the-day",auth,async(req,res) => {
  try {
    let products = await Product.find({});

    products = products.sort((a,b) => {
      let aSum =0;
      let bSum =0;
      for(let i=0;i<a.ratings.length;i++){
        aSum += a.ratings[i].rating;
      }
      for(let i=0;i<b.ratings.length;i++){
        bSum += b.ratings[i].rating;
      }
      return aSum < bSum ? 1 : -1;
    });
    res.json(products[0]);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
})
module.exports = productRouter;