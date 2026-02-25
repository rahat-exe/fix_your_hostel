import express from 'express';
import authMiddleware from '../middleware/auth.middleware.js';
import { adminMiddleware } from '../middleware/admin.middleware.js';
import { approveUser } from '../controllers/user.controllers.js';

const router = express.Router();

router.patch('/approve/:id',authMiddleware, adminMiddleware, approveUser)

export default router