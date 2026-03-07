
import { useGetIssue } from '@/hooks/issue.hooks'
import React, { useEffect } from 'react'
import IssueCard from './IssueCard'

const GetIssues = ({ role }) => {
  const { data, isLoading, error } = useGetIssue();

  if (isLoading) return <p>Loading...</p>;
  if (error) return <p>Something went wrong</p>;

  const issues = Array.isArray(data) ? data : [];

  return (
    <div className="mt-5">
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {(role === "admin"
          ? issues
          : issues.filter((d) => d.type === "public")
        ).map((d) => (
          <IssueCard data={d} key={d._id} />
        ))}
      </div>
    </div>
  );
};

export default GetIssues