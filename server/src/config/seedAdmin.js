import bcrypt from "bcryptjs"
import User from '../models/users.models.js'

export const seedAdmin = async () => {
    const existingAdmin = await User.findOne({role:"admin"});

    if(existingAdmin){
        console.log("Admin already exist")
        return
    }

    const hashedPassword = await bcrypt.hash("admin123", 10);

    await User.create({
        name:"Admin",
        email:"admin@hostel.com",
        password: hashedPassword,
        role:"admin"
    });

    console.log("Default admin created")
}