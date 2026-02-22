import express from 'express'
import { createIssue, getIssues } from '../controllers/issue.controllers.js'
import authMiddleware from '../middleware/auth.middleware.js'
import { downvotesIssue, upvotesIssue } from '../controllers/votes.controllers.js';
import upload from '../middleware/upload.middleware.js';

const router = express.Router();

router.post('/createIssue', authMiddleware, upload.single("image"),  createIssue);
router.get('/getIssues',authMiddleware,getIssues)

router.post("/:id/upvotes", authMiddleware, upvotesIssue)
router.post("/:id/downvotes", authMiddleware, downvotesIssue);


export default router