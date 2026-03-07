"use client";
import GetIssues from "@/components/GetIssues";
import { useRouter } from "next/navigation";
import React, { useEffect } from "react";

const AdminPage = () => {
  const router = useRouter();

  useEffect(() => {
    const token = localStorage.getItem("token");

    if (!token) {
      router.push("/sign-in");
    }

    if (token) {
      const payload = JSON.parse(atob(token.split(".")[1]));
      if (payload.role !== "admin") {
        router.push("/sign-in");
      }
    }
    console.log(token);
  }, []);

  return (
    <section className="max-w-5xl mx-auto p-4">
    <h1>Admin Page</h1>
    <GetIssues role={"admin"} />
  </section>
  )
  
};

export default AdminPage;
