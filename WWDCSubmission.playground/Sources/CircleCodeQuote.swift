import Foundation
import SpriteKit
import AVFoundation
import GameKit

class CircleCodeQuote: SKScene {
    
    let redCircle = SKShapeNode(circleOfRadius: 40)
    let blueCircle = SKShapeNode(circleOfRadius: 40)
    let greenCircle = SKShapeNode(circleOfRadius: 40)
    let yellowCircle = SKShapeNode(circleOfRadius: 40)
    
    let WOneLabel = SKLabelNode(fontNamed: "Marker Felt")
    let WTwoLabel = SKLabelNode(fontNamed: "Marker Felt")
    let DLabel = SKLabelNode(fontNamed: "Marker Felt")
    let CLabel = SKLabelNode(fontNamed: "Marker Felt")
    
    let goodByeBallon = SKSpriteNode(imageNamed: "goodbye_message.png")
    let roundProfileImage = SKSpriteNode(imageNamed: "fingers_crossed_memoji.png")
    let theEndMessage = SKLabelNode(fontNamed: "Marker Felt")
    
    var insertedCode = [String]() {
        didSet {
            self.elementsAddedLabel.text = "Circles Pressed: \(insertedCode.count)"
        }
    }
    
    var instructionLabel = SKLabelNode(fontNamed: "Avenir Next")
    let elementsAddedLabel = SKLabelNode(fontNamed: "Avenir Next")
    let successLabel = SKLabelNode(fontNamed: "Marker Felt")
    let wrongCodeLabel = SKLabelNode(fontNamed: "Marker Felt")
    let enterCodeLabel = SKLabelNode(fontNamed: "Marker Felt")
    let quote = SKLabelNode()
    
    var incorrectTries = 0
    
    let animateInstruction = SKAction.sequence([SKAction.fadeIn(withDuration: 0.9), SKAction.fadeOut(withDuration: 0.9)])
    
    var pressCircle: AVAudioPlayer?
    var wrongCodeSound: AVAudioPlayer?
    var final: AVAudioPlayer?
    var ambientSound: AVAudioPlayer?

    override init() {
        super.init(size: CGSize.zero)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .resizeFill
        self.backgroundColor = #colorLiteral(red: 0.5938511982, green: 0.5938511982, blue: 0.5938511982, alpha: 1)
        
        redCircle.fillColor = #colorLiteral(red: 1, green: 0.2331252352, blue: 0.1760362434, alpha: 1)
        redCircle.strokeColor = .white
        redCircle.lineWidth = 1.5
        redCircle.position = CGPoint(x: 110, y: -250)
        addChild(redCircle)
        
        greenCircle.fillColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        greenCircle.strokeColor = .white
        greenCircle.lineWidth = 1.5
        greenCircle.position = CGPoint(x: -110, y: -250)
        addChild(greenCircle)
        
        blueCircle.fillColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        blueCircle.strokeColor = .white
        blueCircle.lineWidth = 1.5
        blueCircle.position = CGPoint(x: 110, y: 250)
        addChild(blueCircle)
        
        yellowCircle.fillColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        yellowCircle.strokeColor = .white
        yellowCircle.lineWidth = 1.5
        yellowCircle.position = CGPoint(x: -110, y: 250)
        addChild(yellowCircle)
        
        WOneLabel.text = "W"
        WOneLabel.fontSize = 46
        WOneLabel.verticalAlignmentMode = .center
        WOneLabel.horizontalAlignmentMode = .center
        WOneLabel.isHidden = true
        redCircle.addChild(WOneLabel)
        
        WTwoLabel.text = "W"
        WTwoLabel.fontSize = 46
        WTwoLabel.verticalAlignmentMode = .center
        WTwoLabel.horizontalAlignmentMode = .center
        WTwoLabel.isHidden = true
        greenCircle.addChild(WTwoLabel)
        
        DLabel.text = "D"
        DLabel.fontSize = 46
        DLabel.verticalAlignmentMode = .center
        DLabel.horizontalAlignmentMode = .center
        DLabel.isHidden = true
        blueCircle.addChild(DLabel)
        
        CLabel.text = "C"
        CLabel.fontSize = 46
        CLabel.verticalAlignmentMode = .center
        CLabel.horizontalAlignmentMode = .center
        CLabel.isHidden = true
        yellowCircle.addChild(CLabel)
        
        instructionLabel.fontSize = 16
        instructionLabel.text = "Code to favorite quote: 🔴 🟢 🔵 🟡"
        instructionLabel.horizontalAlignmentMode = .center
        instructionLabel.verticalAlignmentMode = .center
        instructionLabel.preferredMaxLayoutWidth = 300
        instructionLabel.numberOfLines = 2
        instructionLabel.position.y = -130
        instructionLabel.isHidden = true
        self.addChild(instructionLabel)
        
        elementsAddedLabel.fontSize = 16
        elementsAddedLabel.text = "Circles Pressed: 0"
        elementsAddedLabel.horizontalAlignmentMode = .center
        elementsAddedLabel.verticalAlignmentMode = .center
        elementsAddedLabel.preferredMaxLayoutWidth = 300
        elementsAddedLabel.numberOfLines = 1
        elementsAddedLabel.position.y = -157
        self.addChild(elementsAddedLabel)
        
        goodByeBallon.size = CGSize(width: 185, height: 185)
        goodByeBallon.position.y = -8
        goodByeBallon.position.x = -35
        goodByeBallon.isHidden = true
        addChild(goodByeBallon)
        
        roundProfileImage.size = CGSize(width: 160, height: 160)
        roundProfileImage.position.y = -143
        roundProfileImage.position.x = 73
        roundProfileImage.isHidden = true
        addChild(roundProfileImage)
        
        theEndMessage.fontSize = 30
        theEndMessage.fontColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        theEndMessage.text = "The End"
        theEndMessage.horizontalAlignmentMode = .center
        theEndMessage.verticalAlignmentMode = .center
        theEndMessage.preferredMaxLayoutWidth = 300
        theEndMessage.numberOfLines = 1
        theEndMessage.position.y = -252
        theEndMessage.isHidden = true
        self.addChild(theEndMessage)
        
        successLabel.fontSize = 50
        successLabel.fontColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        successLabel.text = "UNLOCKING..."
        successLabel.horizontalAlignmentMode = .center
        successLabel.verticalAlignmentMode = .center
        successLabel.preferredMaxLayoutWidth = 300
        successLabel.numberOfLines = 1
        successLabel.position.y = 0
        successLabel.isHidden = true
        self.addChild(successLabel)
        
        enterCodeLabel.fontSize = 40
        enterCodeLabel.fontColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        enterCodeLabel.text = "Click the circles..."
        enterCodeLabel.horizontalAlignmentMode = .center
        enterCodeLabel.verticalAlignmentMode = .center
        enterCodeLabel.preferredMaxLayoutWidth = 300
        enterCodeLabel.numberOfLines = 1
        enterCodeLabel.position.y = 0
        self.addChild(enterCodeLabel)
        
        wrongCodeLabel.fontSize = 30
        wrongCodeLabel.fontColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        wrongCodeLabel.text = "WRONG CODE"
        wrongCodeLabel.horizontalAlignmentMode = .center
        wrongCodeLabel.verticalAlignmentMode = .center
        wrongCodeLabel.preferredMaxLayoutWidth = 300
        wrongCodeLabel.numberOfLines = 1
        wrongCodeLabel.position.y = -90
        wrongCodeLabel.isHidden = true
        self.addChild(wrongCodeLabel)
        
        quote.text = "\"The people who are crazy enough to think they can change the world are the ones who do.\"\n\n-SJ"
        
        let attrString = NSMutableAttributedString(string: quote.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        let range = NSRange(location: 0, length: quote.text!.count)
            
        paragraphStyle.alignment = .center
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        attrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range)
        attrString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Marker Felt", size: 25)!, range: range)
        
        quote.horizontalAlignmentMode = .center
        quote.preferredMaxLayoutWidth = 300
        quote.numberOfLines = 5
        quote.position.y = 115
        quote.isHidden = true
        quote.attributedText = attrString
        self.addChild(quote)
        
        elementsAddedLabel.run(SKAction.repeatForever(animateInstruction))
        
        let pathClickCircleSound = Bundle.main.path(forResource: "circle_clique.wav", ofType: nil)!
        let pressCircleSoundURL = URL(fileURLWithPath: pathClickCircleSound)
        
        do {
            pressCircle = try AVAudioPlayer(contentsOf: pressCircleSoundURL)
        }
        catch {
            print("Can not load sound file.")
        }
        
        let wrongCode = Bundle.main.path(forResource: "wrong_code.wav", ofType: nil)!
        let wrongCodeSoundSoundURL = URL(fileURLWithPath: wrongCode)
        
        do {
            wrongCodeSound = try AVAudioPlayer(contentsOf: wrongCodeSoundSoundURL)
        }
        catch {
            print("Can not load sound file.")
        }
        
        let finalSound = Bundle.main.path(forResource: "final.wav", ofType: nil)!
        let finalSoundURL = URL(fileURLWithPath: finalSound)
        
        do {
            final = try AVAudioPlayer(contentsOf: finalSoundURL)
        }
        catch {
            print("Can not load sound file.")
        }
        
        let pathAmbientSound = Bundle.main.path(forResource: "ambient_suspense.mp3", ofType: nil)!
        let ambientSoundURL = URL(fileURLWithPath: pathAmbientSound)
        
        do {
            ambientSound = try AVAudioPlayer(contentsOf: ambientSoundURL)
        }
        catch {
            print("Can not load sound file.")
        }
        
        ambientSound?.numberOfLoops = -1
        ambientSound?.play()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            self.redCircle.isUserInteractionEnabled = true
            self.greenCircle.isUserInteractionEnabled = true
            self.blueCircle.isUserInteractionEnabled = true
            self.yellowCircle.isUserInteractionEnabled = true
            
            if greenCircle.contains(location) {
                
                WTwoLabel.isHidden = false
                self.insertedCode.append("Y")
                nodeTapped(node: greenCircle)
            }
            else if redCircle.contains(location) {
        
                WOneLabel.isHidden = false
                self.insertedCode.append("W")
                nodeTapped(node: redCircle)
            }
            else if blueCircle.contains(location) {
                
                DLabel.isHidden = false
                self.insertedCode.append("D")
                nodeTapped(node: blueCircle)
            }
            else if yellowCircle.contains(location) {
                
                CLabel.isHidden = false
                self.insertedCode.append("C")
                nodeTapped(node: yellowCircle)
            }
            else {
                self.redCircle.isUserInteractionEnabled = false
                self.greenCircle.isUserInteractionEnabled = false
                self.blueCircle.isUserInteractionEnabled = false
                self.yellowCircle.isUserInteractionEnabled = false
            }
        }
    }
    
    func nodeTapped(node: SKNode) {
        
        let jumpUp = SKAction.move(to: CGPoint(x: node.position.x, y: node.position.y + 35), duration: 0.27)
        let jumpDown = SKAction.move(to: CGPoint(x: node.position.x, y: node.position.y), duration: 0.27)
        let jumpSequence = SKAction.sequence([jumpUp, jumpDown, jumpUp, jumpDown])
        
        pressCircle?.play()
        
        node.run(jumpSequence, completion: {() -> Void in
            
            self.redCircle.isUserInteractionEnabled = false
            self.greenCircle.isUserInteractionEnabled = false
            self.blueCircle.isUserInteractionEnabled = false
            self.yellowCircle.isUserInteractionEnabled = false
            
            if node === self.redCircle {
                self.WOneLabel.isHidden = true
            }
            else if node === self.greenCircle {
                self.WTwoLabel.isHidden = true
            }
            else if node === self.blueCircle {
                self.DLabel.isHidden = true
            }
            else if node === self.yellowCircle {
                self.CLabel.isHidden = true
            }
            
            if self.insertedCode.count >= 4 {
                
                var password = ["W", "Y", "D", "C"]
                var correct = true
                
                for _ in 0 ... 3 {
                    
                    if self.insertedCode[0] != password[0] {
                        correct = false
                    }
                    
                    self.insertedCode.remove(at: 0)
                    password.remove(at: 0)
                }
                
                if correct {
                    
                    let fadeOut = SKAction.fadeOut(withDuration: 1)
                    let fadeIn = SKAction.fadeIn(withDuration: 2)
                    
                    self.enterCodeLabel.run(fadeOut, completion: {() -> Void in
                        self.enterCodeLabel.isHidden = true
                    })
                    
                    self.yellowCircle.run(fadeOut, completion: {() -> Void in
                        self.yellowCircle.isHidden = true
                    })
                
                    self.blueCircle.run(fadeOut, completion: {() -> Void in
                        self.blueCircle.isHidden = true
                    })
                    
                    self.greenCircle.run(fadeOut, completion: {() -> Void in
                        self.greenCircle.isHidden = true
                    })
                    
                    self.redCircle.run(fadeOut, completion: {() -> Void in
                        self.redCircle.isHidden = true
                    })
                    
                    self.elementsAddedLabel.run(fadeOut, completion: {() -> Void in
                        self.elementsAddedLabel.isHidden = true
                    })
                    
                    self.instructionLabel.run(fadeOut, completion: {() -> Void in
                        self.instructionLabel.isHidden = true
                    })
                    
                    self.successLabel.run(fadeOut, completion: {() -> Void in
                        
                        self.ambientSound?.stop()
                        
                        self.successLabel.isHidden = false
                        self.successLabel.run(fadeIn, completion: {() -> Void in
                            
                            self.quote.run(fadeOut, completion: {() -> Void in
                                
                                self.successLabel.isHidden = true
                                self.final?.play()
                                self.quote.isHidden = false
                                self.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
                                
                                self.quote.run(fadeIn, completion: {() -> Void in
                                    
                                    self.roundProfileImage.run(fadeOut, completion: {() -> Void in
                                        
                                        self.roundProfileImage.isHidden = false
                                        self.roundProfileImage.run(fadeIn, completion: {() -> Void in
                                            
                                            self.goodByeBallon.run(fadeOut, completion: {() -> Void in
                                                
                                                self.goodByeBallon.isHidden = false
                                                self.goodByeBallon.run(fadeIn, completion: {() -> Void in
                                                    
                                                    self.theEndMessage.run(fadeOut, completion: {() -> Void in
                                                        
                                                        self.theEndMessage.isHidden = false
                                                        self.theEndMessage.run(fadeIn)
                                                    })
                                                })
                                            })
                                        })
                                        
                                    })
                                })
                            })
                        })
                    })
                    
                    print("Correct code")
                }
                else {
                    
                    let fadeOut = SKAction.fadeOut(withDuration: 3)
                    let fadeIn = SKAction.fadeIn(withDuration: 1)
                    
                    self.wrongCodeSound?.play()
                    
                    self.wrongCodeLabel.isHidden = false
                    self.wrongCodeLabel.run(fadeIn, completion: {() -> Void in
                        self.wrongCodeLabel.run(fadeOut, completion: {() -> Void in
                            self.wrongCodeLabel.isHidden = true
                        })
                    })
                    
                    self.incorrectTries += 1
                    
                    if self.incorrectTries == 1 {
                        self.instructionLabel.isHidden = false
                    }
                    
                    print("Wrong code")
                }
            }
        })
    }
}
