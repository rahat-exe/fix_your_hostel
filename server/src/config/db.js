import mongoose from "mongoose";

export default async function connectDB() {
  try {
    await mongoose.connect(process.env.MONGODB_URL);
    console.log("MongoDb connected");
  } catch (error) {
    console.error(error.message);
    process.exit(1);
  }
}
