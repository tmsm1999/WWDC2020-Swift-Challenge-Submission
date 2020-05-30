import PlaygroundSupport
import AVFoundation
import UIKit
import SpriteKit

class HelloScene: SKScene {
    
    let helloLabel = SKLabelNode(fontNamed: "Marker Felt")
    let profileImage = SKSpriteNode(imageNamed: "hello_memoji.png")

    let messageOne = SKLabelNode()
    let messageTwo = SKLabelNode()
    let messageThree = SKLabelNode()
    let messageFour = SKLabelNode()
    
    let seeIntroductionNode = SKLabelNode(fontNamed: "Marker Felt")
    let skipAndStart = SKLabelNode(fontNamed: "Marker Felt")
    var messagesNodes = [SKLabelNode]()
    
    var introductionSound: AVAudioPlayer?

    override init() {
        super.init(size: CGSize.zero)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .resizeFill
        self.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        profileImage.size = CGSize(width: 150, height: 150)
        profileImage.position.y = 100
        profileImage.isHidden = false
        addChild(profileImage)
        
        helloLabel.text = "Hello!"
        helloLabel.fontSize = 50
        helloLabel.fontColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        helloLabel.horizontalAlignmentMode = .center
        helloLabel.preferredMaxLayoutWidth = 300
        helloLabel.numberOfLines = 1
        helloLabel.position.y = 230
        self.addChild(helloLabel)
        
        seeIntroductionNode.text = "Click here to start..."
        seeIntroductionNode.fontSize = 25
        seeIntroductionNode.fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        seeIntroductionNode.horizontalAlignmentMode = .center
        seeIntroductionNode.preferredMaxLayoutWidth = 300
        seeIntroductionNode.numberOfLines = 1
        seeIntroductionNode.position.y = -100
        self.addChild(seeIntroductionNode)
        
        skipAndStart.text = "Click here to skip introduction..."
        skipAndStart.fontSize = 18
        skipAndStart.fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        skipAndStart.horizontalAlignmentMode = .center
        skipAndStart.preferredMaxLayoutWidth = 300
        skipAndStart.numberOfLines = 1
        skipAndStart.position.y = -155
        self.addChild(skipAndStart)
        
        messageOne.text = "My name is Tomás 🤗. In this Swift Playground I tried to create a fun and interative way to introduce myself. "
        messagesNodes.append(messageOne)
        
        messageTwo.text = "First you will play the Hangman game 🤪. Each word will tell you something about me."
        messagesNodes.append(messageTwo)
        
        messageThree.text = "Pay attention 🧐 to the colors of the \"Next\" and \"Continue\" buttons throughout the playground. They will form a sequence - a secret code."
        messagesNodes.append(messageThree)
        
        messageFour.text = "This code will allow you to unlock and discover my favorite quote ever 🌎. I belive in the power of words to create change.\n\nGood luck!"
        messagesNodes.append(messageFour)
        
        let pathIntroductionSound = Bundle.main.path(forResource: "introduction.wav", ofType: nil)!
        let introductionSoundURL = URL(fileURLWithPath: pathIntroductionSound)
        
        do {
            introductionSound = try AVAudioPlayer(contentsOf: introductionSoundURL)
        }
        catch {
            print("Can not load sound file.")
        }
        
        introductionSound?.numberOfLoops = -1
        introductionSound?.play()
        
        for node in messagesNodes {
            
            let attrString = NSMutableAttributedString(string: node.text!)
            let paragraphStyle = NSMutableParagraphStyle()
            let range = NSRange(location: 0, length: node.text!.count)
            
            paragraphStyle.alignment = .center
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
            attrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range)
            attrString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Marker Felt", size: 20)!, range: range)
        
            node.horizontalAlignmentMode = .center
            node.preferredMaxLayoutWidth = 300
            node.numberOfLines = 5
            node.position.y = -185
            node.isHidden = true
            node.attributedText = attrString
            self.addChild(node)
        
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {

            let location = touch.location(in: self)
            
            if seeIntroductionNode.contains(location) {
                
                seeIntroductionNode.isHidden = true
                skipAndStart.isHidden = true
                presentText()
            }
            else if skipAndStart.contains(location) {

                introductionSound?.stop()
                
                PlaygroundPage.current.liveView = nil
                let hangmanGame = Hangman()
                hangmanGame.preferredContentSize = CGSize(width: 375, height: 667)
                PlaygroundPage.current.liveView = hangmanGame
            }
            
        }
    }
    
    func presentText() {
        
        let fadeOut = SKAction.fadeOut(withDuration: 1)
        let fadeIn = SKAction.fadeIn(withDuration: 1)
                        
        self.messageOne.run(fadeOut, completion: {() -> Void in
            
            self.messageOne.isHidden = false
            self.messageOne.run(fadeIn, completion: {() -> Void in

                sleep(4)
                self.messageOne.run(fadeOut, completion: {() -> Void in
                    
                    self.messageOne.isHidden = true
                    self.messageTwo.run(fadeOut, completion: {() -> Void in
                        
                        self.messageTwo.isHidden = false
                        self.messageTwo.run(fadeIn, completion: {() -> Void in

                            sleep(4)
                            self.messageTwo.run(fadeOut, completion: {() -> Void in
                                
                                self.messageTwo.isHidden = true
                                self.messageThree.run(fadeOut, completion: {() -> Void in
                                    
                                    self.messageThree.isHidden = false
                                    self.messageThree.run(fadeIn, completion: {() -> Void in

                                        sleep(4)
                                        self.messageThree.run(fadeOut, completion: {() -> Void in
                                            
                                            self.messageThree.isHidden = true
                                            self.messageFour.run(fadeOut, completion: {() -> Void in
                                                
                                                self.messageFour.isHidden = false
                                                self.messageFour.run(fadeIn, completion: {() -> Void in

                                                    sleep(4)
                                                    self.messageFour.run(fadeOut, completion: {() -> Void in
                                                        
                                                        self.messageFour.isHidden = true
                                                        self.introductionSound?.stop()
                                                        
                                                        PlaygroundPage.current.liveView = nil
                                                        let hangmanGame = Hangman()
                                                        hangmanGame.preferredContentSize = CGSize(width: 375, height: 667)
                                                        PlaygroundPage.current.liveView = hangmanGame
                                                    })
                                                })
                                            })
                                        })
                                    })
                                })
                            })
                        })
                    })
                })
            })
        })
    }
}
