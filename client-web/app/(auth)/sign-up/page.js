import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import React from 'react'

const SignUp = () => {
  const handleSignUp = async () => {}
  return (
    <div className="flex min-h-screen items-center justify-center">
      <Card className="">
        <CardHeader>
          <CardTitle>Sign up</CardTitle>
          <CardDescription>
            Sign up with your email and password
          </CardDescription>
        </CardHeader>
        <CardContent>
          <form>
            <Input type="email" placeholder="Email" />
            <Input type="password" placeholder="Password" />
            <Input type="password" placeholder="Confirm Password" />
            <Button type="submit">Sign up</Button>
          </form>
        </CardContent>
      </Card>
    </div>
  );
}

export default SignUp