# Movies app
Application is intended to help users find cinema sessions in local cinemas (Azerbaijan).

## Structure
Application consists of two screens:
- Main screen is a collection view that shows movies poster, session times and cinema name. When user clicks on poster, segue is performed to transfer user to the next view controller (detail screen)
- Detail screen shows additional information about movie, such as trailer in youtube, description and imdb rating

## How to build?
1) Clone repo/download zip of the project
2) Open xcode project file in xcode
3) Run on the simulator or virtual device
No additional setup is required

## About source
Application uses firebase realtime database as a networked source to retrieve data about movie sessions. More on realtime database: [Firebase Realtime Database documentation](https://firebase.google.com/docs/database "Firebase Documentation")
