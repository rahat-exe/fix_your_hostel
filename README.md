# FIX YOUR HOSTEL
An app for hostellers to list their issues and complains related to hostel facilities and make it easier to get it fixed
## How It Works
Here Hostellers registers in the app and waits for admin approval, once its approved he can submit his Personal Room Complaint and Hostel Complaints publically or privately with Image.<br><br>Hosteller can upvote or downvote in the existing public hostel complaints of his own hostel regarding the issue to increase its priority  
Admins can track the hostel complaints resolutions in his home page and can see the high priority complaints, Approve hostellers, Filter complaints with Hostel Block, priority, visiblity. After checking the hostel complaint details he can send admin remarks and update progress.<br><br>It simplifies the commmunication between hostellers and authorities with real time updates, voting system, complaint tracking.
## Installation
Follow these steps to run the project locally
### Prerequisites 
- Node.js
- Flutter SDK
- MongoDB 
- ADB (Android Debug Bridge)
- VS Code / Android Studio
### Step 1 : Enable USB Debugginh
Enable USB Debugging from Developer options
Connect your device with your laptop (using USB or type C)
Allow USB Debugging Pop up
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
Open Server folder in integrated terminal
```
cd ./src/
npm start
```


