import React from "react";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card";
import { Label } from "@/components/ui/label";
import { Loader2, PlusCircle } from "lucide-react";

const AddIssueForm = ({ handleSubmit, isPending }) => {
  return (
    <Card className="w-full mt-8 p-4">
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <PlusCircle className="w-5 h-5 text-primary" />
          Add New Issue
        </CardTitle>
      </CardHeader>
      <CardContent>
        <form onSubmit={handleSubmit} className="space-y-6">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {/* Title */}
            <div className="space-y-2">
              <Label htmlFor="title">Issue Title</Label>
              <Input
                id="title"
                name="title"
                placeholder="e.g. Broken Fan"
                required
                disabled={isPending}
              />
            </div>

            {/* Category */}
            <div className="space-y-2">
              <Label htmlFor="category">Category</Label>
              <Input
                id="category"
                name="category"
                placeholder="e.g. Electrical"
                disabled={isPending}
              />
            </div>

            {/* Type - Select */}
            <div className="space-y-2">
              <Label htmlFor="type">Visibility</Label>
              <Select name="type" defaultValue="public" disabled={isPending}>
                <SelectTrigger>
                  <SelectValue placeholder="Select type" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="public">
                    Public
                  </SelectItem>
                  <SelectItem value="private">Private</SelectItem>
                </SelectContent>
              </Select>
            </div>

            {/* Description - Spans full width */}
            <div className="space-y-2 md:col-span-2">
              <Label htmlFor="description">Description</Label>
              <Input
                id="description"
                name="description"
                placeholder="Provide details about the issue..."
                disabled={isPending}
              />
            </div>
          </div>

          <Button
            type="submit"
            className="w-full md:w-max px-8"
            disabled={isPending}
          >
            {isPending ? (
              <>
                <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                Submitting...
              </>
            ) : (
              "Submit Issue"
            )}
          </Button>
        </form>
      </CardContent>
    </Card>
  );
};

export default AddIssueForm;
