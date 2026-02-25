import User from "../models/users.models"

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