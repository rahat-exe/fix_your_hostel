import express from "express";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import User from "../models/users.models.js";

const router = express.Router();
// generate token
const generateToken = (user) => {
  return jwt.sign(
    {
      id: user._id,
      role: user.role,
    },
    process.env.JWT_SECRET,
    {expiresIn:"7d"}
  );
};

// register users(hostellers)
router.post("/register", async (req, res)=>{
    try {
        const {name, email, password, hostelBlock, roomNumber} = req.body;

        // basic validation
        if(!name || !email || !password){
            return res.status(400).json({
                message:"Name, email and password are required"
            })
        }

        // check if email exist
        const existingUser = await User.findOne({email});
        if(existingUser){
            return res.status(400).json({
                message:"User already exists"
            })
        }

        // hashed password
        const hashedPassword = await bcrypt.hash(password, 10);

        // create user
        const user = await User.create({
            name,
            email,
            password:hashedPassword,
            hostelBlock,
            roomNumber,
            role:"hosteller"
        })

        const token = generateToken(user);

        res.status(201).json({
            message:"User registered successfully",
            token,
            user:{
                id:user._id,
                name:user.name,
                email:user.email
            }
        })
    } catch (error) {
        console.error("Error has occured", error);
        res.status(500).json({
            message:"Server error"
        })
    }
})

// login user(hostellers + admin)
router.post("/login", async (req, res)=>{
    try {
      const { email, password } = req.body;

      // validation
      if (!email || !password) {
        return res.status(400).json({
          message: "Email and Password are required",
        });
      }
      // find user
      const user = await User.findOne({ email });

      if (!user) {
        return res.status(400).json({
          message: "Invalid credentials",
        });
      }

      // compare password
      const isMatch = await bcrypt.compare(password, user.password);
      if (!isMatch) {
        return res.status(400).json({
          message: "Invalid credentials",
        });
      }

      // checked if the user is approved or not
      if (user.isApproved === false) {
        return res.status(403).json({
          message: "You are not approved yet",
        });
      }

      const token = generateToken(user);

      res.json({
        message: "Login successfull",
        token,
        user: {
          id: user._id,
          name: user.name,
          email: user.email,
          role: user.role,
        },
      });
    } catch (error) {
        console.error("Login error", error)
        res.status(500).json({message:"Server error"})
    }
})

export default router;
