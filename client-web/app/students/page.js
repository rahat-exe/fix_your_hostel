"use client"
import AddIssue from '@/components/AddIssue';
import GetIssues from '@/components/GetIssues';
import { useRouter } from 'next/navigation';
import React, { useEffect } from 'react'

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
  
  return (
  <section className='max-w-4xl mx-auto p-4'>
    <h1>Hello...{user?.name}</h1>
    <AddIssue />
    <GetIssues />

  </section>
  )
}

export default StudentsPage