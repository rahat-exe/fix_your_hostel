import express from 'express';
import authMiddleware from '../middleware/auth.middleware';
import { adminMiddleware } from '../middleware/admin.middleware';
import { approveUser } from '../controllers/user.controllers';

const router = express.Router();

router.patch('/approve/:id',authMiddleware, adminMiddleware, approveUser)

export default router