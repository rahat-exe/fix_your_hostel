import { cloudinary } from "../config/cloudinary.js";


const uploadToCloudinary =  (buffer, folder='uploads') => {
    // console.log("ENV:", process.env.CLOUD_NAME);
    // console.log(cloudinary.config());

    return new Promise((resolve, reject) => {
        const strem = cloudinary.uploader.upload_stream(
            {folder},
            (error, result) => {
                if(error) reject(error);
                else resolve(result);
            }
        );
        strem.end(buffer);
    })
};

export {uploadToCloudinary};