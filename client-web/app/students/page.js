"use client"
import AddIssue from '@/components/AddIssue';
import GetIssues from '@/components/GetIssues';
import { Button } from '@/components/ui/button';
import { useRouter } from 'next/navigation';
import React, { useEffect, useState } from 'react'
import {plus} from "lucide-react"
import Link from 'next/link';

const StudentsPage = () => {
  const router = useRouter();

  let user;
  useEffect(() => {
   const token = localStorage.getItem("token");

   if(!token){
    router.push("/sign-in");
   }

   if(token){
      const payload = JSON.parse(atob(token.split(".")[1]));
      if(payload.role !== "hosteller"){
       router.push("/sign-in");
      }
   }
   user =localStorage.getItem("user")
   console.log(user)

  
  },[])

  const [add, setAdd] = useState(false)
   const issueDisplay = () =>{
    setAdd((prev) => !prev)
   }
  return (
    <section className="max-w-5xl mx-auto p-4">
      <h1>Hello...{user?.name}</h1>
      <div className='flex justify-between items-center '>
        <Button
          className={`h-20 w-1/2 `}
          variant="outline"
          onClick={issueDisplay}
        >
          Add a Issue
        </Button>
        <Button className={`h-20 w-1/2`} variant="outline">
          <Link href="students/all-issues"> View your issues</Link>
          
        </Button>
      </div>

      {add && <AddIssue />}

      <GetIssues role={"hosteller"} />
    </section>
  );
}

export default StudentsPage