import express from 'express'
import { createIssue } from '../controllers/issue.controllers.js'
import authMiddleware from '../middleware/auth.middleware.js'

const router = express.Router();

router.post('/createIssue', authMiddleware, createIssue)

export default router