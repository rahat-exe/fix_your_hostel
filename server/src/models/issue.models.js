import mongoose from "mongoose";

const issueSchema = new mongoose.Schema(
  {
    title: {
      type: String,
      required: true,
      trim: true,
    },
    description: {
      type: String,
      required: true,
      trim: true,
    },
    category: {
      type: String,
      enum: ["maintenance", "cleanlines", "personal", "others"],
      default: "others",
    },

    type: {
      type: String,
      enum: ["public", "private"],
      required: true,
    },

    createdBy: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
      // index: true,
    },

    status: {
      type: String,
      enum: ["pending", "in-progess", "resolved"],
      default: "pending",
      // index: true,
    },
    upvotes: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
      },
    ],
    upvotes: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
      },
    ],

    adminRemarks: {
      type: String,
      default: "",
    },

    priority: {
      type: String,
      enum: ["low", "medium", "high"],
      default: "medium",
      index: true,
    },
  },
  { timestamps: true },
);

issueSchema.index({ type: 1, status: 1 });
issueSchema.index({ createdAt: -1 });

export default mongoose.model("Issue", issueSchema)