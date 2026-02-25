export const adminMiddleware = (req, res, next) =>{
    try {
        if(!req.user){
            return res.status(401).json({
                succuss:false,
                message:"Not authenticated"
            })
        }

        if(req.user.role !== "admin"){
            return res.status(403).json({
                success:true,
                message:"Access denied. Admin only."
            })
        }

        next()
    } catch (error) {
        console.error(error);
        return res.status(500).json({
            success:false,
            message:"Server error",
            error:error.message
        })
    }
}