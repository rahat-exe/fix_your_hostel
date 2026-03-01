import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import Link from 'next/link';
import React from 'react'

const SignIn = () => {
  return (
    <div className="flex min-h-screen items-center justify-center ">
      <Card className="">
        <CardHeader>
          <CardTitle>Sign in</CardTitle>
          <CardDescription>
            Sign up with your email and password
          </CardDescription>
        </CardHeader>
        <CardContent>
          <form className="space-y-4">
            <Input type="email" placeholder="Email" required />
            <Input type="password" placeholder="Password" required/>
            <Input type="password" placeholder="Confirm Password" required/>
            <Button type="submit">Sign In</Button>
          </form>
         <CardDescription className={`mt-4`}>Don't have an account? <Link className='text-blue-400' href="/sign-up">Sign Up</Link></CardDescription>
        </CardContent>
      </Card>
    </div>
  );
}

export default SignIn