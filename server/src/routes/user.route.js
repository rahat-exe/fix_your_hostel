import express from 'express';
import authMiddleware from '../middleware/auth.middleware.js';
import { adminMiddleware } from '../middleware/admin.middleware.js';
import { approveUser, deleteUser, getAllUsers } from '../controllers/user.controllers.js';

const router = express.Router();

router.patch('/approve/:id',authMiddleware, adminMiddleware, approveUser)
router.get("/users",authMiddleware,adminMiddleware, getAllUsers)
router.delete("/user/:id", authMiddleware, adminMiddleware, deleteUser)

export default router