import { isObjectIdOrHexString } from 'mongoose';
import Issue from '../models/issue.models.js'
export const upvotesIssue = async (req, res) => {
    try {
        const issue = await Issue.findById(req.params.id);
        if(!issue){
            return res.status(404).json({message: "Issue not found"})
        }

        const userId = req.user.id;
        // remove user from the downvotes
        issue.downvotes = issue.downvotes.filter((id) => id.toString() !== userId)

        // toggle
        if(issue.upvotes.includes(userId)){
            issue.upvotes = issue.upvotes.filter((id) => id.toString !== userId)
        }else{
            // add
            issue.upvotes.push(userId)
        }

        await issue.save();

        res.status(200).json({
            message:"Vote updated",
            upvotes:issue.upvotes.length,
            downvotes:issue.downvotes.length
        })

    } catch (error) {
        res.status(500).json({
            message:"Server error"
        })
    }
};

export const downvotesIssue = async (req, res) => {
    try {
        const issue = await Issue.findById(req.params.id)
        if(!issue){
            return res.status(404).json({message:"Issue not found"});
        }

        const userId = req.user.id;

        // remove form upvotes
        issue.upvotes = issue.upvotes.filter((id) => id.toString() !== userId)

        if(issue.downvotes.includes(userId)){
            issue.downvotes = issue.downvotes.filter((id) => id.toString() !== userId)
        }else{
            issue.downvotes.push(userId)
        }

        await issue.save()

        res.status(200).json({
          success: true,
          message: "Vote updated",
          upvotes: issue.upvotes.length,
          downvotes: issue.downvotes.length,
        });
    } catch (error) {
         res.status(500).json({
           message: "Server error",
         });
    }
};