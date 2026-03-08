"use client"
import AddIssue from '@/components/AddIssue';
import GetIssues from '@/components/GetIssues';
import { Button } from '@/components/ui/button';
import { useRouter } from 'next/navigation';
import React, { useEffect, useState } from 'react'
import {plus, User} from "lucide-react"
import Link from 'next/link';
import Profile from '@/components/Profile';

const StudentsPage = () => {
  const router = useRouter();

  const [user, setUser] = useState(null)
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
   const storedUser =JSON.parse(localStorage.getItem("user"))
   setUser(storedUser)

  
  },[])

  const [add, setAdd] = useState(false)
  const [profileView, setProfileView] = useState(false)
   const issueDisplay = () =>{
    setAdd((prev) => !prev)
   }
   const profileViewBtn = () => {
    setProfileView(prev => !prev)
   }
  return (
    <section className="max-w-5xl mx-auto p-4">
      <div className="flex justify-between items-center ">
        <div className="flex gap-3">
          <Button
            className={`h-15 w-3/4  `}
            variant="outline"
            onClick={issueDisplay}
          >
            Add a Issue
          </Button>
          
            <Button className={`h-15 w-3/4 `} variant="outline" onClick={() => router.push("/students/all-issues")}>
              View your issues
            </Button>
         
        </div>
        <div className="relative">
          <Button
            className={`h-15 w-15 rounded-full  flex items-center justify-center`}
            variant="outline"
            onClick={profileViewBtn}
          >
            <User />
          </Button>
          {profileView && <Profile />}
        </div>
      </div>

      {add && <AddIssue />}

      <GetIssues role={"hosteller"} />
    </section>
  );
}

export default StudentsPage