import express from 'express'
import { createIssue, deleteIssue, deleteYourIssue, editIssueStatus, editRemarks, getIssues, getYourIssue } from '../controllers/issue.controllers.js'
import authMiddleware from '../middleware/auth.middleware.js'
import { downvotesIssue, upvotesIssue } from '../controllers/votes.controllers.js';
import { upload } from '../config/cloudinary.js';


const router = express.Router();

router.post('/createIssue', authMiddleware, upload.single("image"),  createIssue);
router.get('/getIssues',authMiddleware,getIssues)
// to delete hosteller's private and public issue
router.delete('/deleteIssue/:id',authMiddleware,deleteYourIssue)
router.get('/students/issues',authMiddleware,getYourIssue)

router.post("/:id/upvotes", authMiddleware, upvotesIssue)
router.post("/:id/downvotes", authMiddleware, downvotesIssue);

// for editing the status of the issue--done by admin only
router.patch("/:id/status", authMiddleware, editIssueStatus);
router.delete("/:id/issue", authMiddleware, deleteIssue)

//for adding admin remarks
router.patch("/:id/remarks",authMiddleware, editRemarks)







export default router