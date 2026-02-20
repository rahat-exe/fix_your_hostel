import express from 'express'
import cors from 'cors'
import dotenv from 'dotenv'
dotenv.config()
import connectDB from './src/config/db.js'

const PORT = process.env.PORT

const app = express();
connectDB()

app.use(cors())
app.use(express.json())

app.get('/', (req, res) => {
    res.json("Hello from backend!!")
})

app.listen(PORT, ()=> {
    console.log("Server running on Port: ", PORT)
})