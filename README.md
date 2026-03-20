# FIX YOUR HOSTEL
An app for hostellers to list their issues and complains related to hostel facilities and make it easier to get it fixed
## How It Works
Here Hostellers registers in the app and waits for admin approval, once its approved he can submit his Personal Room Complaint and Hostel Complaints publically or privately with Image.<br><br>Hosteller can upvote or downvote in the existing public hostel complaints of his own hostel regarding the issue to increase its priority  
Admins can track the hostel complaints resolutions in his home page and can see the high priority complaints, Approve hostellers, Filter complaints with Hostel Block, priority, visiblity. After checking the hostel complaint details he can send admin remarks and update progress.<br><br>It simplifies the commmunication between hostellers and authorities with real time updates, voting system, complaint tracking.
## Features - 
#### Hosteller -
- Raise complaints (room / public)
- Upvote / downvote complaints
- Track complaint status
- View updates & remarks
#### Admin -
- View all complaints
- Filter by block / status / visibility
- Update progress (Pending / In Progress / Resolved)
- Add remarks
## Tech Stack 
- Frontend : Flutter
- Backend : Node.js, express.js
- Database : MongoDB
- Other tools : Cloudinary
## Screenshots 
 - Admin
<br>[Admin Dashboard](screenshots/admin_home.jpeg)<br>
[Admin Complaint](screenshots/admin_complaint.jpeg)<br>
[Admin Private Complaint Details](screenshots/admin_private_complaints_details.jpeg)<br>
[Admin Public Complaint Details](screenshots/admin_public_complaints_details.jpeg)<br>
[Admin Approval](screenshots/admin_approval.jpeg)<br>
 - Hosteller
<br>[Hosteller Dashboard](screenshots/hosteller_home.jpeg)<br>
[Hosteller Add Issue](screenshots/hosteller_add_issue.jpeg)<br>
[Hosteller Waiting](screenshots/hosteller_waiting.jpeg)<br>
[Hosteller Account](screenshots/hosteller_account.jpeg)<br>

## Installation
Follow these steps to run the project locally
### Prerequisites 
- Node.js
- Flutter SDK
- MongoDB 
- ADB (Android Debug Bridge)
- VS Code / Android Studio
### Step 1 : Enable USB Debugging
- Enable USB Debugging from Developer options
- Connect your device with your laptop (using USB or type C)
- Allow USB Debugging Pop up
### Step 2 : ADB setup
check for adb devices in command prompt
```
adb devices
```
if your devices appears then paste this line in command prompt 
```
adb reverse tcp:5000 tcp:5000
```
check for connection
```
adb reverse --list
```
### Step 3 : Backend Setup
- Open Server folder in integrated terminal
```
cd ./src/
npm start
```
- create .env folder inside /server
```
PORT=5000
MONGODB_URL=YOUR_MONGODB_URL
JWT_SECRET=YOUR_JWT_SECRET
```
- Install **POSTMAN**
- create a new post request
- Use endpoint
```
http://localhost:5000/api/auth/register
```
- Send Request with Request Body to add Admin manually
```
name : "Admin"
email : "admin@hostel.com"
password : "admin123"
role : "admin"
hostelBlock : null
roomNumber : null
isActive : true
isApproved : "true"
```
### Step 4 : Cloudinary Setup (For images)
 - Create **Cloudinary** Account
 - Copy your **Cloud name, API Key, API secret**
Update **.env** inside **/server**
```
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret
```
### Step 5 : Flutter App Setup 
```
cd client
flutter pub get
```
- Click on **Run without Debugging** from the top menu bar
