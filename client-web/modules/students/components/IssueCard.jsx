import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
  CardDescription,
} from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { useDeleteIssue } from "@/hooks/issue.hooks";

export default function IssueCard({ data }) {
    const { _id } = data;
        const {mutate,error,isPending} = useDeleteIssue();
    const onDelete = async () => {
        mutate(data._id)
    }
  return (
    <Card className="">
      <CardHeader>
        <CardTitle>{data.title}</CardTitle>
        <CardDescription>
          Category: {data.category} | Priority: {data.priority}
        </CardDescription>
      </CardHeader>

      <CardContent className="space-y-3">
        <p className="text-sm text-muted-foreground">{data.description}</p>

        <div className="text-sm space-y-1">
          <p>
            <b>Status:</b> {data.status}
          </p>
          <p>
            <b>Type:</b> {data.type}
          </p>
          <p>
            <b>Created By:</b> {data.createdBy?.name}
          </p>
          <p>
            <b>Email:</b> {data.createdBy?.email}
          </p>
        </div>

        <div className="flex justify-between items-center pt-3">
          <span className="text-xs text-muted-foreground">
            {new Date(data.createdAt).toLocaleString()}
          </span>

          <Button variant="destructive" onClick={() => onDelete(data._id)}>
            Delete
          </Button>
        </div>
      </CardContent>
    </Card>
  );
}
