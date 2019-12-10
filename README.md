ABOUT
MoodMusic is an iOS app that creates customized playlists based on user preferences. 
The app uses Spotify’s API for song categorization and playlist creation. 

Music suggestions are based on factors such as the location (public setting, bedroom, office etc.), the number of people, loudness, and how formal the environment is. We decided to use Spotify due to its large database that describes the music on thorough various factors such as its energy level, rhythm, etc.

Our primary motivation is to facilitate the process of choosing music for different events. We want to save people's time. Instead of spending hours on putting various songs together, people could spend their time on socialization or resting. 

TECHNOLOGY
MoodMusic is an iOS app created in XCode environment. It is written in Swift and Objective-C languages and also uses libraries such CocoaPods and Spartan. 

We are using Model-View-Controller (MVC) software design pattern that separates the internal code (Model -- backend) from the way the information is presented (Views, Controllers -- Frontend).

The user confirms Spotify authentication, answers the survey that takes in quantitative values for songs categorization, the app processes the responses, creates the playlist and exports it to your Spotify account. 
