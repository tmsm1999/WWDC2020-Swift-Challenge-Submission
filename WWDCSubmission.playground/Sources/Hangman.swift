import Foundation
import UIKit
import PlaygroundSupport
import AVFoundation


class Hangman: UIViewController {
    
    var clueLabel = UILabel()
    var triesLabel = UILabel()
    var wordLabel = UILabel()
    let objectLabel = UILabel()
    
    var currentHangmanImage = UIImageView()
    
    let firstRowOfButtons = UIView()
    let secondRowOfButtons = UIView()
    let thirdRowOfButtons = UIView()
    let fourthRowOfButtons = UIView()
    var blackView = UIView()
    
    var hiddenButtons = [UIButton]()
    
    var game: Game!
    var currentGame = 0
    var totalGuessWords = 0
    var numberOfWordsInGame = 0
    var letter: String?
    
    let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    var rightLetterPressed: AVAudioPlayer?
    var wrongLetterPressed: AVAudioPlayer?
    var victorySound: AVAudioPlayer?
    var defeatSound: AVAudioPlayer?
    var transitionSound: AVAudioPlayer?
    var backgroundMusic: AVAudioPlayer?
    
    override func loadView() {
        let view = UIView()

        view.backgroundColor = #colorLiteral(red: 1, green: 0.8366613989, blue: 0.08758396113, alpha: 1)
        
        clueLabel.translatesAutoresizingMaskIntoConstraints = false
        clueLabel.font = UIFont(name: "MarkerFelt-Wide", size: 45)
        clueLabel.textColor = UIColor.black
        clueLabel.textAlignment = .center
        view.addSubview(clueLabel)
        
        currentHangmanImage.translatesAutoresizingMaskIntoConstraints = false
        currentHangmanImage.contentMode = .scaleAspectFit
        currentHangmanImage.image = UIImage(named: "Hangman-5.png")
        view.addSubview(currentHangmanImage)
        
        triesLabel.translatesAutoresizingMaskIntoConstraints = false
        triesLabel.textColor = UIColor.black
        triesLabel.font = UIFont(name: "MarkerFelt-Thin", size: 17)
        triesLabel.textAlignment = .center
        view.addSubview(triesLabel)
        
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.layer.borderWidth = 3
        wordLabel.layer.cornerRadius = 10
        wordLabel.layer.borderColor = UIColor.black.cgColor
        wordLabel.textColor = UIColor.black
        wordLabel.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        wordLabel.textAlignment = .center
        view.addSubview(wordLabel)
        
        firstRowOfButtons.translatesAutoresizingMaskIntoConstraints = false
        firstRowOfButtons.layer.borderColor = UIColor.black.cgColor
        firstRowOfButtons.layer.cornerRadius = 10
        firstRowOfButtons.layer.borderWidth = 3
        firstRowOfButtons.clipsToBounds = true
        firstRowOfButtons.backgroundColor = #colorLiteral(red: 0.5607796308, green: 0.5607796308, blue: 0.5607796308, alpha: 1)
        view.addSubview(firstRowOfButtons)
        
        secondRowOfButtons.translatesAutoresizingMaskIntoConstraints = false
        secondRowOfButtons.layer.borderColor = UIColor.black.cgColor
        secondRowOfButtons.layer.cornerRadius = 10
        secondRowOfButtons.layer.borderWidth = 3
        secondRowOfButtons.clipsToBounds = true
        secondRowOfButtons.backgroundColor = #colorLiteral(red: 0.5607796308, green: 0.5607796308, blue: 0.5607796308, alpha: 1)
        view.addSubview(secondRowOfButtons)
        
        thirdRowOfButtons.translatesAutoresizingMaskIntoConstraints = false
        thirdRowOfButtons.layer.borderColor = UIColor.black.cgColor
        thirdRowOfButtons.layer.cornerRadius = 10
        thirdRowOfButtons.layer.borderWidth = 3
        thirdRowOfButtons.clipsToBounds = true
        thirdRowOfButtons.backgroundColor = #colorLiteral(red: 0.5607796308, green: 0.5607796308, blue: 0.5607796308, alpha: 1)
        view.addSubview(thirdRowOfButtons)
        
        fourthRowOfButtons.translatesAutoresizingMaskIntoConstraints = false
        fourthRowOfButtons.layer.borderColor = UIColor.black.cgColor
        fourthRowOfButtons.layer.cornerRadius = 10
        fourthRowOfButtons.layer.borderWidth = 3
        fourthRowOfButtons.clipsToBounds = true
        fourthRowOfButtons.backgroundColor = #colorLiteral(red: 0.5607796308, green: 0.5607796308, blue: 0.5607796308, alpha: 1)
        view.addSubview(fourthRowOfButtons)
        
        self.view = view
        
        NSLayoutConstraint.activate([
            
            clueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clueLabel.bottomAnchor.constraint(equalTo: currentHangmanImage.topAnchor, constant: -30),
            clueLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            currentHangmanImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentHangmanImage.bottomAnchor.constraint(equalTo: triesLabel.topAnchor, constant: -20),
            currentHangmanImage.widthAnchor.constraint(equalToConstant: 165),
            currentHangmanImage.heightAnchor.constraint(equalToConstant: 165),
            
            triesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            triesLabel.bottomAnchor.constraint(equalTo: wordLabel.topAnchor, constant: -37),
            
            wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordLabel.bottomAnchor.constraint(equalTo: firstRowOfButtons.topAnchor, constant: -30),
            wordLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80),
            wordLabel.heightAnchor.constraint(equalToConstant: 45),
            
            firstRowOfButtons.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstRowOfButtons.heightAnchor.constraint(equalToConstant: 45),
            firstRowOfButtons.widthAnchor.constraint(equalToConstant: 270),
            firstRowOfButtons.bottomAnchor.constraint(equalTo: secondRowOfButtons.topAnchor, constant: -2),
            
            secondRowOfButtons.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondRowOfButtons.heightAnchor.constraint(equalToConstant: 45),
            secondRowOfButtons.widthAnchor.constraint(equalToConstant: 315),
            secondRowOfButtons.bottomAnchor.constraint(equalTo: thirdRowOfButtons.topAnchor, constant: -2),
            
            thirdRowOfButtons.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thirdRowOfButtons.heightAnchor.constraint(equalToConstant: 45),
            thirdRowOfButtons.widthAnchor.constraint(equalToConstant: 270), //45 * 6
            thirdRowOfButtons.bottomAnchor.constraint(equalTo: fourthRowOfButtons.topAnchor, constant: -2),
            
            fourthRowOfButtons.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fourthRowOfButtons.heightAnchor.constraint(equalToConstant: 45),
            fourthRowOfButtons.widthAnchor.constraint(equalToConstant: 315), // 45 * 7
            fourthRowOfButtons.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45)
        
        ])
        
        var letter = 0
        let buttonRows = [firstRowOfButtons, secondRowOfButtons, thirdRowOfButtons, fourthRowOfButtons]
        let numberOfButtonsPerRow = [6, 7, 6, 7]
        let buttonDimentionSide = 45
        
        var index = 0
        
        for row in buttonRows {
            for place in 0 ... numberOfButtonsPerRow[index] - 1 {
                
                let newButton = UIButton(type: .system)
                newButton.setTitle(alphabet[letter], for: .normal)
                newButton.setTitleColor(UIColor.black, for: .normal)
                
                newButton.addTarget(self, action: #selector(letterButtonPressed), for: .touchUpInside)
                
                let frame = CGRect(x: place * buttonDimentionSide, y: 0, width: buttonDimentionSide, height: buttonDimentionSide)
                newButton.frame = frame
                
                newButton.layer.borderWidth = 1
                newButton.layer.borderColor = UIColor.black.cgColor
                
                row.addSubview(newButton)
                letter += 1
                
            }
            index += 1
        }
        
        let pathWinSound = Bundle.main.path(forResource: "correct_letter_final.mp3", ofType: nil)!
        let winSoundURL = URL(fileURLWithPath: pathWinSound)
        
        do {
            rightLetterPressed = try AVAudioPlayer(contentsOf: winSoundURL)
        }
        catch {
            print("Can not load sound file.")
        }
        
        let pathWrongSound = Bundle.main.path(forResource: "wrong_letter_pressed.wav", ofType: nil)!
        let wrongSoundURL = URL(fileURLWithPath: pathWrongSound)
        
        do {
            wrongLetterPressed = try AVAudioPlayer(contentsOf: wrongSoundURL)
        }
        catch {
            print("Can not load sound file.")
        }
        
        let pathVictorySound = Bundle.main.path(forResource: "victory_sound.wav", ofType: nil)!
        let victorySoundURL = URL(fileURLWithPath: pathVictorySound)
        
        do {
            victorySound = try AVAudioPlayer(contentsOf: victorySoundURL)
        }
        catch {
            print("Can not load sound file.")
        }
        
        let pathDefeatSound = Bundle.main.path(forResource: "defeat_sound.wav", ofType: nil)!
        let defeatSoundURL = URL(fileURLWithPath: pathDefeatSound)
        
        do {
            defeatSound = try AVAudioPlayer(contentsOf: defeatSoundURL)
        }
        catch {
            print("Can not load sound file.")
        }
        
        let pathIntroductionSound = Bundle.main.path(forResource: "Hangman_music.mp3", ofType: nil)!
        let introductionSoundURL = URL(fileURLWithPath: pathIntroductionSound)
        
        do {
            backgroundMusic = try AVAudioPlayer(contentsOf: introductionSoundURL)
        }
        catch {
            print("Can not load sound file.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundMusic?.numberOfLoops = -1
        backgroundMusic?.volume = 0.6
        backgroundMusic?.play()
        
        game = Game()
        newGame()
    }
    
    func newGame() {
        
        game.newGame()
        print(game.getCurrentWord())
        
        if(game.getGameNumber() <= 5) {
            initLabelsAndButtons()
        }
        else {
        
        }
    }
    
    @objc func letterButtonPressed(_ sender: UIButton) {
        
        sender.isHidden = true
        hiddenButtons.append(sender)
        
        let buttonLetter: String? = sender.currentTitle?.uppercased()
        
        if buttonLetter != nil {
            
            if game.checkLetterInWord(letter: buttonLetter!) == true {
                
                rightLetterPressed?.play()
                wordLabel.text = game.getStringInLabel()
                
                if game.checkVictory() {
                    DispatchQueue.main.async { [weak self] in
                        self?.victorySound?.play()
                        self?.presentHagmanWordEnds()
                    }
                }
            }
            else {
                
                wrongLetterPressed?.play()
                updateNumberOfTriesLeftLabelAndHangmanImage()
                
                if game.getNumberOfTriesLeft() == 0 {
                    DispatchQueue.main.async { [weak self] in
                        self?.defeatSound?.play()
                        self?.presentHagmanWordEnds()
                    }
                }
            }
        }
    }
    
    func initLabelsAndButtons() {
        
        wordLabel.text = game.getStringInLabel()
        
        for button in hiddenButtons {
            button.isHidden = false
        }
        
        clueLabel.text = game.getClueForCurrentWord()
        updateNumberOfTriesLeftLabelAndHangmanImage()
    }
    
    func updateNumberOfTriesLeftLabelAndHangmanImage() {
        triesLabel.text = "Number of tries left: \(game.getNumberOfTriesLeft())"
        currentHangmanImage.image = UIImage(named: game.getCurrentHangmanImage())
    }
    
    func presentHagmanWordEnds() {
        
        blackView = UIView()
        blackView.translatesAutoresizingMaskIntoConstraints = false
        blackView.backgroundColor = UIColor.black.withAlphaComponent(0.96)
        blackView.alpha = 0
        view.addSubview(blackView)
        
        NSLayoutConstraint.activate([
            self.blackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.blackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.blackView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.blackView.heightAnchor.constraint(equalTo: self.view.heightAnchor)
        ])
        
        DispatchQueue.main.async {
            UIView.transition(with: self.blackView, duration: 1.5, options: [], animations: {
                
                self.blackView.alpha = 1
            
            }, completion: {(Bool) -> Void in
                
                let image = UIImage(named: self.game.getMemoji())
                let myPhotograph = UIImageView()
                myPhotograph.layer.borderWidth = 2
                myPhotograph.contentMode = UIView.ContentMode.scaleAspectFit
                myPhotograph.layer.borderColor = UIColor.white.cgColor
                myPhotograph.frame = CGRect(x: 180, y: 240, width: 120, height: 120)
                myPhotograph.layer.cornerRadius = myPhotograph.frame.size.width / 2
                myPhotograph.clipsToBounds = true
                myPhotograph.image = image
                self.blackView.addSubview(myPhotograph)

                let ballonImage = UIImage(named: self.game.getCurrentBallon())
                let ballonView = UIImageView()
                ballonView.frame = CGRect(x: 40, y: 28, width: 240, height: 200)
                ballonView.image = ballonImage
                self.blackView.addSubview(ballonView)

                let paragraph = UITextView()
                paragraph.backgroundColor = #colorLiteral(red: 0.7995668718, green: 0.7995668718, blue: 0.7995668718, alpha: 1)
                paragraph.font = UIFont(name: "Avenir Next", size: 15)
                paragraph.textAlignment = NSTextAlignment.justified
                paragraph.layer.cornerRadius = 10
                paragraph.layer.borderColor = UIColor.white.cgColor
                paragraph.layer.borderWidth = 2
                paragraph.isScrollEnabled = false
                paragraph.isEditable = false
                paragraph.text = self.game.getCurrentParagraph()
                paragraph.translatesAutoresizingMaskIntoConstraints = false
                self.blackView.addSubview(paragraph)

                let nextButton = UIButton()
                
                if self.game.getGameNumber() == self.game.getTotalNumberOfWords() - 1 {
                    nextButton.setTitle("Continue", for: .normal)
                }
                else {
                        nextButton.setTitle("Next word", for: .normal)
                }
                
                if self.game.getGameNumber() == 0 {
                    nextButton.backgroundColor = #colorLiteral(red: 1, green: 0.2331252352, blue: 0.1760362434, alpha: 1)
                }
                else if self.game.getGameNumber() == 1 {
                    nextButton.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                }
                else if self.game.getGameNumber() == 2 {
                    nextButton.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
                }
                else if self.game.getGameNumber() == 3 {
                    nextButton.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
                }
                
                nextButton.setTitleColor(UIColor.black, for: .normal)
                nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
                nextButton.layer.borderWidth = 1.5
                nextButton.layer.cornerRadius = 10
                nextButton.layer.borderColor = UIColor.white.cgColor
                nextButton.addTarget(self, action: #selector(self.goToNextWord), for: .touchUpInside)
                nextButton.translatesAutoresizingMaskIntoConstraints = false
                self.blackView.addSubview(nextButton)

                NSLayoutConstraint.activate([

                    paragraph.widthAnchor.constraint(equalToConstant: 280),
                    paragraph.centerXAnchor.constraint(equalTo: self.blackView.centerXAnchor),
                    paragraph.topAnchor.constraint(equalTo: self.blackView.layoutMarginsGuide.topAnchor, constant: 370),

                    nextButton.centerXAnchor.constraint(equalTo: self.blackView.centerXAnchor),
                    nextButton.bottomAnchor.constraint(equalTo: self.blackView.layoutMarginsGuide.bottomAnchor, constant: -18),
                    nextButton.widthAnchor.constraint(equalToConstant: 160),
                    nextButton.heightAnchor.constraint(equalToConstant: 43),
                ])
                
                for _ in 1 ... 10 {

                    let objectView = UIView()
                    objectView.translatesAutoresizingMaskIntoConstraints = false
                    objectView.frame = CGRect(x: 50, y: 50, width: 20, height: 100)
                    objectView.isHidden = false

                    let ballon = UILabel()
                    ballon.translatesAutoresizingMaskIntoConstraints = false
                    ballon.frame = CGRect(x: 50, y: 50, width: 20, height: 100)
                    ballon.text = self.game.getEmojiFloating()
                    ballon.font = UIFont.systemFont(ofSize: 60)
                    objectView.addSubview(ballon)

                    NSLayoutConstraint.activate([
                        ballon.centerXAnchor.constraint(equalTo: objectView.centerXAnchor),
                        ballon.centerYAnchor.constraint(equalTo: objectView.centerYAnchor)
                    ])

                    self.blackView.addSubview(objectView)
                    self.blackView.bringSubviewToFront(objectView)

                    let randomXOffset = Int.random(in: -120 ..< 270)

                    let path = UIBezierPath()
                    path.move(to: CGPoint(x: 270 + randomXOffset, y: 1000))
                    path.addCurve(to: CGPoint(x: 100 + randomXOffset, y: -300), controlPoint1: CGPoint(x: 300 - randomXOffset, y: 600), controlPoint2: CGPoint(x: 70 + randomXOffset, y: 300))

                    let animation = CAKeyframeAnimation(keyPath: "position")
                    animation.path = path.cgPath
                    animation.repeatCount = 1
                    animation.duration = Double.random(in: 4.0 ..< 7.0)
                    
                    let delegate = BallonAnimationDelegate()
                    delegate.didFinishAnimation = {
                        objectView.removeFromSuperview()
                    }
                    animation.delegate = delegate

                    objectView.layer.add(animation, forKey: "animate position along path")
                }
            })
        }
    }
    
    @objc func goToNextWord() {
        
        if game.getGameNumber() == game.getTotalNumberOfWords() - 1 {
            
            PlaygroundPage.current.liveView = Conclusion()
            return
        }
        else {
            DispatchQueue.main.async {
                UIView.transition(with: self.blackView, duration: 2.2, options: [.transitionFlipFromTop], animations: {
                    
                    self.blackView.alpha = 0
                }, completion: nil)
            }
            
            newGame()
        }
    }
}
