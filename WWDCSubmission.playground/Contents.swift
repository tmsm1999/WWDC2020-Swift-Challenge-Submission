/*:
 # About Myself
  
  Hello! 🤗 My name is Tomás. I am 21 years old and I study Computer Science. 💻 Since I can remember I have been in love with technology and what is possible to create with it.
  
  I started learning how to program in Pyhton when I was 16 and quickly moved on to Java. I am passionate about software engineering and Artificial Intelligence 🧠. Next year I am going to graduate school to pursue a Master's Degree in Computer Science. As Steve Jobs would say "I want to put a ding in the Universe" with my work.
  
  I love my family, I love reading and I am huge fan of cinema 🎞. I quckly fall in love with good stories that convey a strong message.
  
  
 # Motivation
  
  My childhood experiences and my sisters are the main reason that my playground exists. When we were younger we loved to play games together 🎲. We liked card games, Mastermind and several board games .
  
  But our favorite was the Hangman game. We would go to the dictionary to try and find the most complicated world we possible could. Occasionally we invented a few words to upset each other... 🤣😅😇
  
  That is why I included the Hangman game in my Playground. It means a lot to me and it was a big part of my childhood days. In my Playground I tried to create a fun and interesting way to introduce myself. There are eight different words that can appear. Each time only four are selected. Each word in the Hangman game says something about me.
 
 # WWDC and me
  
  For years I have been watching the WWDC Keynote and presentations from home, and every year I wished I was there with everybody else. I dream of meeting Tim Cook, Craig Federighi and all the awesome Apple Engineers.
  
  WWDC is the oportunity I need to improve my skills, have great conversations with other scholarship winners and hopefully create friendships and memories that will last for a lifetime.
 
  Thank you for considering my submission! 🙃
 
 # Credits
 
  All resources used in this playground are free:
 
 * [Pixabay - an international, copyleft and free-to-use website for sharing photos](https://pixabay.com)
 * [Wikimedia Commons - an online repository of free-use images, sounds, other media](https://commons.wikimedia.org/wiki/Main_Page)
 * [Freesound - a collaborative repository of Creative Commons licensed audio samples](https://freesound.org)
 
 # Note
 When creating my Playground I used Xcode running on a 2017 MacBook Air. During the development process I found that if I quit Xcode and open my playground again sometimes it would not run properly the first time. However, if I ran it again it always worked and never failed. I think it may be my Mac that is not very powerful but if you experience this issue please try and run the playground again. Thank you*/
import PlaygroundSupport
import UIKit
import SpriteKit

let startingScene = Introduction()
startingScene.preferredContentSize = CGSize(width: 375, height: 667)
PlaygroundPage.current.liveView = startingScene
