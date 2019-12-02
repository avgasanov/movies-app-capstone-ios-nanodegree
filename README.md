# Movie sessions app
Application is intended to help users find cinema sessions in local cinemas (Azerbaijan).

## Structure
Application consists of two screens:
- Main screen is a collection view that shows movies poster, session times and cinema name. When user clicks on poster, segue is performed to transfer user to the next view controller (detail screen)
- Detail screen shows additional information about movie, such as a trailer in youtube, description and imdb rating

## How to build?
1) Clone repo/download zip of the project
2) Open xcode project file in Xcode (.xcworkspace)
3) Run on the simulator or virtual device
No additional setup is required

## Troubleshooting
#### Pod files
In case if you have build errors due to missing files:
1) Install Cocoa Pods using: sudo gem install cocoapods
2) Run "pod update" command in project folder
3) Run project using .xcworkspace file

## About source
Application uses firebase realtime database as a networked source to retrieve data about movie sessions. More on realtime database: [Firebase Realtime Database documentation](https://firebase.google.com/docs/database "Firebase Documentation")
