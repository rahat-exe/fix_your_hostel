import Issue from "../models/issue.models.js";
import cloudinary from '../config/cloudinary.js'

export const createIssue = async (req, res) => {
  try {
    const { title, description, visibility, images } = req.body;

    if (!title || !visibility) {
      return res
        .status(400)
        .json({ message: "Title and visibility is required" });
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
      visibility,
      user: req.user.id,
      images: uploadedImage ? [uploadedImage] : []
    });

    res.status(200).json({
        message:"Issue created successfully",
        issue
    })
  } catch (error) {
    res.status(500).json({message:"Server Error"})
  }
};

export const getIssues = async (req, res) => {
  try {
    let issues;
    if(req.user.role === "admin"){
        issues = await Issue.find().populate("user", "name email");
    }else{
        issues = await Issue.find({
          $or: [{ visibility: "public" }, { user: req.user.id }],
        }).populate("user", "name email");
    }
    res.status(200).json(issues)
  } catch (error) {
    console.log(error)
    res.status(500).json({message:"Server Error"})
  }
};
