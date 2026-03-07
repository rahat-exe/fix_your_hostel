"use client"
import React from 'react'
import {Input} from '@/components/ui/input'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from './ui/select';
import { Button } from './ui/button';
import { useCreateIssue } from '@/hooks/issue.hooks';
import AddIssues from './AddIssues'

const AddIssue =  () => {
  const { data,mutate, isPending, error } = useCreateIssue();

  const handleSubmit = async (e) => {
    e.preventDefault();
    const data = new FormData(e.currentTarget);
    const title = data.get('title');
    const description = data.get('description');
    const type = data.get('type');
    const category = data.get('category');

    console.log(title, description, type, category);

    mutate({ title, description, type, category });

    console.log(data)

    
  }
  return (
    <div>
      <AddIssues handleSubmit={handleSubmit} isPending={isPending} />
    </div>
  );
}

export default AddIssue