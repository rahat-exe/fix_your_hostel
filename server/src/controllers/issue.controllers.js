import Issue from "../models/issue.models.js";

export const createIssue = async (req, res) => {
  try {
    const { title, description, visibility, images } = req.body;

    if (!title || !visibility) {
      return res
        .status(400)
        .json({ message: "Title and visibility is required" });
    }

    const issue = await Issue.create({
      title,
      description,
      visibility,
      user: req.user.id,
    });

    res.status(200).json({
        message:"Issue created successfully",
        issue
    })
  } catch (error) {
    res.status(500).json({message:"Server Error"})
  }
};
