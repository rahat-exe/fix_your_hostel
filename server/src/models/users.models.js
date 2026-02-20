import mongoose from "mongoose";

const userSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
    trim: true,
    lowercase: true,
  },
  password: {
    type: String,
    required: true,
  },
  role:{
    type:String,
    enum:["hosteller", "admin"],
    default:"hosteller"
  },
  hostelBlock:{
    type:String,
    default:null,
  },
  roomNumber:{
    type:String,
    default:null,
  },
  isActive:{
    type:Boolean,
    default:true,
  }
},{
    timestamps:true
});

userSchema.index({email:1})

export default mongoose.model("User", userSchema)