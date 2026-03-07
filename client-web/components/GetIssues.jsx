
import { useGetIssue } from '@/hooks/issue.hooks'
import React, { useEffect } from 'react'
import IssueCard from './IssueCard'

const GetIssues = ({role}) => {
  const {data, isLoading, error} = useGetIssue()
  console.log(data)
  if(isLoading) return <p>Loading...</p>
  
  return (
    <div className="mt-5">
      <div className="grid grid-cols-1 gap-3 md:grid-cols-2 space-y-4">
        
        {role === "admin"
          ? data.map((d) => <IssueCard data={d} key={d.id} />)
          : data.map(
              (d) => d.type === "public" && <IssueCard data={d} key={d.id} />,
            )}
      </div>
    </div>
  );
}

export default GetIssues