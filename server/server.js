import express from 'express'
import cors from 'cors'
import { v2 as cloudinary } from "cloudinary";
import dotenv from 'dotenv'
dotenv.config()
import connectDB from './src/config/db.js'
import { seedAdmin } from './src/config/seedAdmin.js';
import authRoutes from './src/routes/auth.route.js'
import issueRoute from './src/routes/issue.route.js'
import userRoute from './src/routes/user.route.js'


const PORT = process.env.PORT

console.log(process.env.CLOUD_API_KEY);


cloudinary.config({
  cloud_name: process.env.CLOUD_NAME,
  api_key: process.env.CLOUD_API_KEY,
  api_secret: process.env.CLOUD_API_SECRET
})

console.log("Cloudinary config:", cloudinary.config());

const app = express();
connectDB();


app.use(cors())
app.use(express.json());

await seedAdmin();

app.get('/health', (req, res) => {
    res.json("Hello from backend!!")
})

app.use('/api/auth',authRoutes)
app.use('/api/issue', issueRoute)
app.use('/api/users', userRoute)

app.listen(PORT, ()=> {
    console.log("Server running on Port: ", PORT);
    console.log("restarting")
})