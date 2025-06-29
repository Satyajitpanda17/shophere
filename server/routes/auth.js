const express = require("express");
const User = require("../models/user.js");
const bcryptjs = require("bcryptjs");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth_middleware.js");


authRouter.post('/api/signup', async (req,res) => {
try{
    const {name,email,password} = req.body;
const existedUser = await User.findOne({email});
if(existedUser){
    return res.status(400).json({msg : "User already exists!"});
}
const hashedPassword = await bcryptjs.hash(password,8);
var user = new User({
    email,
    password : hashedPassword,
    name,
})
user = await user.save();
res.json({user, msg : "User registered successfully"});
} catch(e) {
    res.status(500).json({error : e.message});
}
});

authRouter.post('/api/signin', async (req,res) => {
    try {
        const {email,password} = req.body;
        const user = await User.findOne({email});
        if(!user){
            return res.status(400).json({msg:"User not found.."});
        }
        const isMatch = await bcryptjs.compare(password,user.password);
        if(!isMatch){
            return res.status(400).json({msg:"Email or Password is incorrect"});
        }
        const token = jwt.sign({id: user._id}, "passwordKey");
        res.json({token, ...user._doc});

    } catch (e) {
        res.status(500).json({error : e.message});
    }
});

authRouter.post("/tokenIsValid", async (req,res) => {
    try {
        const token = req.header('x-auth-token');
        if(!token) return res.json(false);
        const isVerified = jwt.verify(token, 'passwordKey');
        if(!isVerified) return res.json(false);

        const user = await User.findById(isVerified.id);
        if(!user) return res.json(false);
        res.json(true);
    } catch (e) {
        res.status(500).json({error : e.message});
    }
});

authRouter.get('/', auth, async (req,res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});

module.exports = authRouter;