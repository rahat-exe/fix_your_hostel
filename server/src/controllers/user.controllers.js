import User from "../models/users.models.js"

export const approveUser = async (req, res) => {
    try {
      const {id} = req.params;
      
      const user = await User.findById(id);
      if(!user){
        return res.status(404).json({
            success:false,
            message:"User not found"
        })
      }
      
      user.isApproved = true;
      await user.save();

    //   const user = await User.findByIdAndUpdate(
    //     id,
    //     { isApproved: true },
    //     { new: true },
    //   );

    //   if (!user) {
    //     return res.status(404).json({
    //       message: "User not found",
    //     });
    //   }

      res.status(200).json({
        success:true,
        message:"User approved successfully"
      })
    } catch (error) {
       console.error(error);
       res.status(500).json({
        success:true,
        message:"Server Error",
        error:error.message
       }) 
    }
}

export const getAllUsers = async (req, res) => {
  try {
    const users = await User.find({}).sort({createdAt:-1});

    if(!users.length){
      return res.status(404).json({
        success:false,
        message:"No user found"
      })
    }

    return res.status(200).json({
      success:true,
      message:"User fetch successfully",
      data:users
    })

  } catch (error) {
    console.error(error)
    res.status(500).json({
      success:false,
      message:"Server error",
      error:error.message
    })
  }
}

export const deleteUser = async (req, res)=>{
  try {
    const {id} = req.params;

    const deleteUser = await User.findByIdAndDelete(id);
    if(!deleteUser){
      return res.status(404).json({
        success:false,
        message:"No user found"
      })
    }

    res.status(200).json({
      success:true,
      message:"User deleted successfully"
    })
  } catch (error) {
    console.log(error);
    res.status(500).json({
      success:false,
      message:"Server error"
    })
  }
}