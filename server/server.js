import dotenv from 'dotenv'
import express from 'express'
import cors from 'cors'
import connectDB from './src/config/db.js'
import { seedAdmin } from './src/config/seedAdmin.js';
import authRoutes from './src/routes/auth.route.js'
import issueRoute from './src/routes/issue.route.js'
import userRoute from './src/routes/user.route.js'

dotenv.config()

const PORT = process.env.PORT

const app = express();
connectDB()


app.use(cors())
app.use(express.json())
app.use(express.urlencoded({ extended: true }));

await seedAdmin();

app.get('/', (req, res) => {
    res.json("Hello from backend!!")
})

app.use('/api/auth',authRoutes)
app.use('/api/issue', issueRoute)
app.use('/api/users', userRoute)

app.listen(PORT, ()=> {
    console.log("Server running on Port: ", PORT)
})