import Foundation
import UIKit

public class Game {
    
    var word = ""
    var clue = ""
    var currentHangmanImage = ""
    var currentBallonImage = ""
    var numberOfTriesLeft = 6
    var gameNumber = -1
    var currentWordNumberOfChars = 0
    var stringInLabel = ""
    var emojiFloating = ""
    var memoji = ""
    
    let differentHangmanImages = ["Hangman-0.png", "Hangman-1.png", "Hangman-2.png", "Hangman-3.png", "Hangman-4.png", "Hangman-5.png", "Hangman-6.png"]
    let differentBallonImages = ["ballon_1.png", "ballon_2.png", "ballon_3.png", "ballon_4.png"]
    let wrongBallon = "wrong_ballon"
    let startGameWords = ["PORTUGAL", "TENNIS", "APPLE", "COMPUTER", "QUEEN", "PILOT", "CINEMA", "READING"]
    let startWordClue = ["COUNTRY", "SPORT", "FRUIT", "OBJECT", "BAND", "PROFESSION", "ART", "HOBBY"]
    
    let startParagraphs = [
        
        "I am from Portugal 🇵🇹, a small European country. I live in Porto, one of the best european destinations to travel to. We are friendly and we have a really nice weather. We are also European Champions of Football - the one played with the feet... 🤣\n\nDon't forget... Colors...",
        
        "I started playing tennis 🎾 when I was 4 years old and I played in tournaments until I was 14. All my close family plays well and we love watching the Grand Slam finals together 🙌. Our favorite player is Roger Federer. I also love Rafael Nadal and Novak Djokovic. After all, these are The Big Three and they are all very special players.",
        
        "I love Apple! To me the company represents creativity, brilliance and a force for good with the power to create change by giving the people the tools they need to create something great and inspiring. My first Apple product was the iPod Nano and recently I was able to buy my first iPhone. 🤩 A dream come true. 📱",

        "My favorite object is my computer - a 2017 MacBook Air. I have learned a lot using it and all my Computer Science projects are done on it. I like to think my MacBook knows as much as me... Honestly, I just love using my Mac and macOS is the best OS ever 🤗.\n\nDo you remember the colors?",

        "I love Queen! 👑 All the elements of the band are such great musicians and I can't pass a week without listening to them. I love Rock 🎸 and I got into it because of my mom and dad. They are big fans of Queen, Pink Floyd and Dire Straits, just to name a few.\n\nAre you paying attention to the colors?",

        "In my early teens I had the dream of becoming a pilot... 🛩 I love airplanes! I wanted to know all about them. In my free time I would print images of different types of airplanes and label all the different parts. At that time, my favorite film was \"Top Gun\". I also had a flight simulator and I ended up with more than 100 hours of flight. 🤣",

        "I love love cinema! In fact, I try to go to the cinema as much as possible. I quickly fall in love with great stories that inspire me. I can't say I have a favorite film. There are so many I love... But if a had to pick four I would probably choose \"The Imitation Game\", \"The Theory of Everything\", \"Titanic\" and \"Interstellar\" 🚀.",
        
        "I love to read! 📚 I love that feeling of not sensing the time passing by when I am curled up with a good book. My passion for reading started with \"Harry Potter\" when I was 13. How I love those books... Currently, I am reading the last book of \"A Song of Ice and Fire\".\n\nHow many colors have you seen so far?"
    ]
    
    var gameWords = [String]()
    var wordClue = [String]()
    var paragraphs = [String]()
    
    public init() {
        
        var indexes = [0, 1, 2, 3, 4, 5, 6, 7]
        indexes.shuffle()
        
        for i in 0 ... 3 {
            
            self.gameWords.append(self.startGameWords[indexes[i]])
            self.wordClue.append(self.startWordClue[indexes[i]])
            self.paragraphs.append(self.startParagraphs[indexes[i]])
        }
    }
    
    public func newGame() {
        gameNumber += 1
        
        if gameNumber > gameWords.count - 1 {
            return
        }
        
        word = gameWords[gameNumber]
        clue = wordClue[gameNumber]
        
        currentWordNumberOfChars = word.count
        
        stringInLabel = ""
        for _ in 0 ... currentWordNumberOfChars - 1 {
            stringInLabel += "?"
        }
        
        numberOfTriesLeft = 6
        currentHangmanImage = differentHangmanImages[numberOfTriesLeft]
    }
    
    public func checkLetterInWord(letter: String) -> Bool {
        
        let wordCharacters = Array(word)
        var labelCharacters = Array(stringInLabel)
        var letterIsInWord = false
        
        var i = 0
        for char in wordCharacters {
            if char == Character(letter) {
                labelCharacters[i] = Character(letter)
                letterIsInWord = true
            }
            i += 1
        }
        
        if letterIsInWord {
            stringInLabel = String(labelCharacters)
        }
        else {
            numberOfTriesLeft -= 1
            
            if numberOfTriesLeft >= 0 {
                currentHangmanImage = differentHangmanImages[numberOfTriesLeft]
            }
                
            if numberOfTriesLeft == 0 {
                currentBallonImage = wrongBallon
            }
            
            emojiFloating = "🤪"
            memoji = "wrong_memoji.png"
        }
        
        return letterIsInWord
    }
    
    public func checkVictory() -> Bool {
        
        for char in stringInLabel {
            if char == "?" {
                return false
            }
        }
        
        currentBallonImage = differentBallonImages[gameNumber]
        
        numberOfTriesLeft = 6
        currentHangmanImage = differentHangmanImages[numberOfTriesLeft]
        
        emojiFloating = "🎈"
        memoji = "right_memoji.png"
        
        return true
    }
    
    public func getCurrentWord() -> String {
        return word
    }
    
    public func getClueForCurrentWord() -> String {
        return clue
    }
    
    public func getGameNumber() -> Int {
        return gameNumber
    }
    
    public func getNumberOfTriesLeft() -> Int {
        return numberOfTriesLeft
    }
    
    public func getCurrentHangmanImage() -> String {
        return currentHangmanImage
    }
    
    public func getStringInLabel() -> String {
        return stringInLabel
    }
    
    public func getCurrentParagraph() -> String {
        paragraphs[gameNumber]
    }
    
    public func getCurrentBallon() -> String {
        return currentBallonImage
    }
    
    public func getEmojiFloating() -> String {
        return emojiFloating
    }
    
    public func getTotalNumberOfWords() -> Int {
        return gameWords.count
    }
    
    public func getMemoji() -> String {
        return memoji
    }
}
