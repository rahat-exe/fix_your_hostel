"use client"
import { useGetYourIssue } from '@/hooks/issue.hooks';
import IssueCard from '@/modules/students/components/IssueCard';
import React from 'react'

const AllIssues = () => {
    const {data,isLoading,isError} = useGetYourIssue();
    console.log("all issues",data)

    // const issues = Array.isArray(data) ? data : (data?.data ?? []);
    const issues = data?.data ?? [];

    console.log(issues)
    if(isLoading) return <p>Loading...</p>;
    if(isError) return <p>Something went wrong</p>;
  return (
    <div className=" grid grid-cols-1 md:grid-cols-2 max-w-5xl gap-4 mx-auto mt-10">
      {issues.map((d) => (
        <div key={d._id}>
          <IssueCard data={d} />
        </div>
      ))}
    </div>
  );
}

export default AllIssues