# Alumni_Connect_App
[![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)]()
[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://github.com/Pranavchiku/Alumni_Connect_App)
[![Django](https://img.shields.io/badge/django-%23092E20.svg?style=for-the-badge&logo=django&logoColor=white)](https://www.djangoproject.com/)
[![DjangoREST](https://img.shields.io/badge/DJANGO-REST-ff1709?style=for-the-badge&logo=django&logoColor=white&color=ff1709&labelColor=gray)](https://www.django-rest-framework.org/)
## Overview
We are trying to create an application to apply concepts learnt in Database management system course, which will provide you an opportunity to connect to Alumnis' of IIT Jodhpur.
## Built using:
- [Flutter: ](https://flutter.dev/docs/get-started/codelab) Flutter documentation
- [Dart: ](https://dart.dev/) Dart documentation
- [Django :](https://www.djangoproject.com/) Django documentation used
- [Django Rest Api: ](https://www.django-rest-framework.org/) API documentation used
## Application Features
- Login/Logout
- Signin/Signup
- View and update user profile
- A page to manage connections
- Provision to send connection requests.
- Post latest updates
- Showing suggestion based on field of interest
- Page for showing suggestion of alumni of particular field
  - SDE
  - DS
  - MBA
  - Others
- Tried to implement Connection Graph (GraphSQL) using oneToMany Field.
- Normalised the tables to highest normal form
- Easy query addressing
- Frontend and backend interacting via rest API
## How to Use:
Step 1: \
Download or clone this repository by using the link below:
```
https://github.com/Pranavchiku/Alumni_Connect_App.git
```

Step 2: \
Run backend Server (make sure port 8001 is free)
```
cd Django_backend
sh migration.sh
```
Step 3:\
Run app
```
cd Flutter_frontend
```
Step 4: \
Open the project in an IDE and execute the following command in console to get the required dependencies:
```
flutter pub get
```
Step 5: \
Run the project by executing the below piece of code in console:
```
flutter run
```
If the code shows no sound null safety error, run the below code:
```
flutter run --no-sound-null-safety
```
If the code still do not run \
Step 6: 
```
flutter clean
```
Step 7: 
```
flutter upgrade
```
## Collaborators:
| Name | Year | Branch|
| ------------- | ------------- | ------------- |
| Harshita Kalani (B20CS019)  | PreFinal  | CSE |
| Pranav Goswami (B20CS016) | PreFinal  | CSE |
| Sanidhya S. Johri (B20CS061) | PreFinal | CSE |
## Screenshots:
<p float="left">
<img src = "https://github.com/Pranavchiku/Alumni_Connect_App/blob/main/Pictures/1.png?raw=true" width="150" height="300">
<img src = "https://github.com/Pranavchiku/Alumni_Connect_App/blob/main/Pictures/2.png?raw=true" width="150" height="300">
<img src = "https://github.com/Pranavchiku/Alumni_Connect_App/blob/main/Pictures/3.png?raw=true" width="150" height="300">
<img src = "https://github.com/Pranavchiku/Alumni_Connect_App/blob/main/Pictures/4.png?raw=true" width="150" height="300">
<img src = "https://github.com/Pranavchiku/Alumni_Connect_App/blob/main/Pictures/5.png?raw=true" width="150" height="300">
</p>
<p float="left">
<img src = "https://github.com/Pranavchiku/Alumni_Connect_App/blob/main/Pictures/6.png?raw=true" width="150" height="300">
<img src = "https://github.com/Pranavchiku/Alumni_Connect_App/blob/main/Pictures/7.png?raw=true" width="150" height="300">
<img src = "https://github.com/Pranavchiku/Alumni_Connect_App/blob/main/Pictures/8.png?raw=true" width="150" height="300">
<img src = "https://github.com/Pranavchiku/Alumni_Connect_App/blob/main/Pictures/9.png?raw=true" width="150" height="300">
</p>
