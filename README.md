# GitBook

Github users lookup application

<img src="screenshots/1.png" width="998">
<img src="screenshots/2.png" width="998">

## Installation

Open GitBook.xcodeproj on Xcode & Run

## Environment
Xcode Version 14.0 (14A309)

iOS 15.4 Simulator and Device

swift-driver version: 1.45.2 

Apple Swift version 5.6 
## Dependency

Github API
- "/users/:owner"
- "/users/:owner/repos"

## Features
- [x] User list screen
    - [x] Display a list of users
    - [x] Required elements for each line
        - [x] icon image
        - [x] username
    - [x] Transition to the user repository screen by selecting each line
- [x] User repository screen
    - [x] Display user details at the top of the list
        - [x] Icon image
        - [x] User name
        - [x] Full name
        - [x] Number of followers
        - [x] Number of followers
- [x] The following lists user's repositories that are not forked repositories
    - [x] Repository name
    - [x] Development language
    - [x] Number of Stars
    - [x] Description
- [x] Tap a row in the repository list to display the URL of the repository in WebView  
- [x] Refresh Repo and User data
- [x] Refresh interval (currently 5 secs)
- [x] Display Forked and Non-Forked Only
- [x] Minimum offline support using coredata

## Note

SwiftUI + Clean architecture + MVVM

Felix Chon 
####
