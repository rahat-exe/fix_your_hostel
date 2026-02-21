import jwt from 'jsonwebtoken'

const authMiddleware = (req, res, next) =>{
    const authHeader = req.headers.authorization;

    if(!authHeader || !authHeader.startsWith("Bearer")){
        return res.status(401).json({message:"Not authrized, no token"})
    }

    const token = authHeader.split(" ")[1];

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        req.user = decoded;
        next()
    } catch (error) {
        return res.status(401).json({message: "Token Invalid"})
    }
}

export default authMiddleware