import express from 'express'
import cors from 'cors'
import dotenv from 'dotenv'
dotenv.config()
import connectDB from './config/db.js'
import { seedAdmin } from './config/seedAdmin.js';
import authRoutes from './routes/auth.route.js'
import issueRoute from './routes/issue.route.js'
import userRoute from './routes/user.route.js'


const PORT = process.env.PORT

const app = express();
connectDB()


app.use(cors())
app.use(express.json())

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