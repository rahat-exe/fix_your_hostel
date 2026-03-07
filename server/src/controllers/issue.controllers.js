import cloudinary from "../config/cloudinary.js";
import Issue from "../models/issue.models.js";


export const createIssue = async (req, res) => {
  try {
    const { title, description, type, category } = req.body;

    

    if (!title || !type || !description) {
      return res
        .status(400)
        .json({ message: "Title and type is required" });
    }

   
    let uploadedImage;

    const issue = await Issue.create({
      title,
      description,
      type,
      createdBy: req.user.id,
      category,
      images: uploadedImage ? [uploadedImage] : [],
    });


    res.status(200).json({
        message:"Issue created successfully",
        data:issue
        
    })
  } catch (error) {
    console.log(error);
    res.status(500).json({message:"Server Error",
      error: error.message,
      message:error
    })
  }
};

export const getIssues = async (req, res) => {
  try {
    let issues;
    if(req.user.role === "admin"){
        issues = await Issue.find().populate("createdBy", "name email");
    }else{
        issues = await Issue.find({
          $or: [{ type: "public" }, { createdBy: req.user.id }],
        }).populate("createdBy", "name email hostelBlock roomNumber");
    }
    res.status(200).json(issues)
  } catch (error) {
    console.log(error)
    res.status(500).json({message:"Server Error",error})
  }
};

export const editIssueStatus = async (req, res) => {
  try {
    const {id} = req.params;
    const {role} = req.user;
    const {status} = req.body;

    if(role !== "admin"){
      return res.status(401).json({
        success:false,
        message:"Only admin has the access"
      })
    }

    const issue = await Issue.findByIdAndUpdate(id, {status:status}, {new:true})

    if(!issue){
      return res.status(404).json({
        success:false,
        message:"Issue not found"
      })
    }

    res.status(200).json({
      success:true,
      message:"Issue status updated successfully",
      data:issue
    })
    
  } catch (error) {
    console.error(error);
    res.status(500).json({
      success:false,
      message:"Server error",
      error:error.message
    })
  }
}
// to delete issue -- admin only
export const deleteIssue = async (req, res) =>{
  try {
    const {id} = req.params;
    const {role} = req.user;

    if(role !== "admin"){
      return res.status(401).json({
        success:false,
        message:"Only admin has the access"
      })
    }

    const deletedIssue = await Issue.findByIdAndDelete(id);

    if(!deletedIssue){
      return res.status(404).json({
        success: false,
        message: "Issue not found"
      })
    }

    return res.status(200).json({
      success:true,
      message:"Issue deleted",
      data:deletedIssue,

    })

    
  } catch (error) {
    console.error("Something went wrong", error);
    return res.status(500).json({
      success:false,
      message:"Server error",
      error:error.message
    })
  }
}

export const editRemarks = async (req, res) =>{
  try {
    const { adminRemarks } = req.body;
    const {role} = req.user;
    const {id} = req.params;

    if(role !== "admin"){
      return res.status(403).json({success:false, message:"Only admins can add remarks"})
    }
    if (!adminRemarks) {
      return res.status(400).json({
        success: false,
        message: "Remarks are required",
      });
    }

    const editingRemarks = await Issue.findByIdAndUpdate(id, { adminRemarks :adminRemarks.trim()}, {new:true});
    if(!editingRemarks){
       return res.status(404).json({success:false, message:"Issue not found"})
    }

    res.status(200).json({success:true, message:"Admin remarks added successfully"})
  } catch (error) {
    console.log(error);
    res.status(500).json({success:false, message:"Server error",error:error.message})
  }
}

// to delete issue -- user only that belongs to him
export const deleteYourIssue = async (req, res) => {
  try {
    const {id , role} = req.user;
    const {id:issueId} = req.params;

    if(role !== "hosteller"){
      return res.status(403).json({
        success:false,
        message:"Access denied"
      })
    }

    const issue = await Issue.findOneAndDelete({
      _id:issueId,
      createdBy:id
    })
    if(!issue){
      return res.status(404).json({
        success:false,
        message:"No issue found"
      })
    }

    res.status(200).json({
      success:true,
      message:"Issue deleted successfully"
    })

  } catch (error) {
    console.error(error);
    res.status(500).json({
      success:false,
      message:"Server error",
      error:error.message
    })
  }
}


// to get all issue -- user only -- that belongs to him
export const getYourIssue = async (req, res) => {
  try {
    const {id:userId} = req.user;

    const issues = await Issue.find({
      createdBy:userId
    })
    if(!issues){
      return res.status(404).json({
        success:false,
        message:"No issue found"
      })
    }

    res.status(200).json({
      success:true,
      message:"Issues found",
      data:issues
    })
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      success:false,
      message:"Server error",
      error:error.message
    })
  }
}