import React from "react";
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import {
  CalendarIcon,
  AlertCircle,
  ThumbsUp,
  ThumbsDown,
  Clock,
} from "lucide-react";

const IssueCard = ({ data }) => {
  // Destructure for cleaner access
  const {
    title,
    description,
    priority,
    status,
    createdAt,
    createdBy,
    upvotes,
    downvotes,
  } = data;

  const formattedDate = new Date(createdAt).toLocaleDateString("en-US", {
    month: "short",
    day: "numeric",
    year: "numeric",
  });

  // Dynamic styling for Priority
  const priorityStyles = {
    high: "bg-destructive/10 text-destructive border-destructive/20",
    medium: "bg-amber-100 text-amber-700 border-amber-200",
    low: "bg-emerald-100 text-emerald-700 border-emerald-200",
  };

  // Dynamic styling for Status
  const statusStyles = {
    pending: "bg-slate-100 text-slate-600",
    "in-progress": "bg-blue-100 text-blue-600",
    resolved: "bg-green-100 text-green-600",
  };

  return (
    <Card className="max-w-md border-t-4 border-t-primary">
      <CardHeader className="pb-3">
        <div className="flex items-center justify-between mb-2">
          <Badge
            variant="outline"
            className={`${priorityStyles[priority]} font-bold`}
          >
            {priority.toUpperCase()}
          </Badge>
          <div className="flex items-center text-xs text-muted-foreground">
            <CalendarIcon className="mr-1 h-3 w-3" />
            {formattedDate}
          </div>
        </div>
        <CardTitle className="text-xl">{title}</CardTitle>
        <CardDescription className="italic">
          {description === "..." ? "No details provided." : description}
        </CardDescription>
      </CardHeader>

      <CardContent className="grid gap-4">
        <div className="flex items-center space-x-4 rounded-md border p-3">
          <Avatar>
            <AvatarFallback className="bg-slate-200">
              {createdBy.name
                .split(" ")
                .map((n) => n[0])
                .join("")}
            </AvatarFallback>
          </Avatar>
          <div className="flex-1 space-y-1">
            <p className="text-sm font-medium leading-none">{createdBy.name}</p>
            <p className="text-xs text-muted-foreground">{createdBy.email}</p>
          </div>
        </div>
      </CardContent>

      <CardFooter className="flex justify-between items-center bg-slate-50/50 py-3">
        <div className="flex space-x-3">
          <div className="flex items-center text-sm text-slate-500">
            <ThumbsUp className="mr-1 h-4 w-4" />
            {upvotes.length}
          </div>
          <div className="flex items-center text-sm text-slate-500">
            <ThumbsDown className="mr-1 h-4 w-4" />
            {downvotes.length}
          </div>
        </div>

        <div className="flex items-center gap-2">
          <Clock className="h-4 w-4 text-slate-400" />
          <Badge className={`${statusStyles[status]} capitalize`}>
            {status}
          </Badge>
        </div>
      </CardFooter>
    </Card>
  );
};

export default IssueCard;
