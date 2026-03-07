"use client"
import { useGetYourIssue } from '@/hooks/issue.hooks';
import React from 'react'

const AllIssues = () => {
    const {data,isLoading,isError} = useGetYourIssue();
    console.log("all issues",data)
  return (
    <div>AllIssues</div>
  )
}

export default AllIssues