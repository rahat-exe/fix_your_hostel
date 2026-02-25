import Issue from "../models/issue.models.js";
import cloudinary from '../config/cloudinary.js'

export const createIssue = async (req, res) => {
  try {
    const { title, description, type } = req.body;

    if (!title || !type) {
      return res
        .status(400)
        .json({ message: "Title and type is required" });
    }

    let uploadedImage;

    if(req.file){
      const uploadResult = await new Promise((resolve, reject) => {
        const stream = cloudinary.uploader.upload_stream({
          folder:"fix-your-hostel"
        },
        (error, result) =>{
          if(error) reject(error);
          else resolve(result)
        }
      )
      stream.end(req.file.buffer)
      })
      uploadedImage = uploadResult.secure_url;

    }

    const issue = await Issue.create({
      title,
      description,
      type,
      createdBy: req.user.id,
      images: uploadedImage ? [uploadedImage] : [],
    });

    res.status(200).json({
        message:"Issue created successfully",
        issue
    })
  } catch (error) {
    res.status(500).json({message:"Server Error",error})
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
        }).populate("createdBy", "name email");
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

    return res.status(200).json({
      success:true,
      message:"Issue deleted",
      data:deleteIssue,

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
