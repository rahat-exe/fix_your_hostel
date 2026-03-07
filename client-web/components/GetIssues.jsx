
import { useGetIssue } from '@/hooks/issue.hooks'
import React, { useEffect } from 'react'
import IssueCard from './IssueCard'

const GetIssues = () => {
  const {data, isLoading, error} = useGetIssue()
  console.log(data)
  if(isLoading) return <p>Loading...</p>
  
  return (
    <div className='max-w-5xl mx-auto p-4'>
      <div className='grid grid-cols-1 gap-3 md:grid-cols-2 '>
      {data.map((d)=>(
          <IssueCard data={d} />
        ))}
        </div>
    </div>
  )
}

export default GetIssues