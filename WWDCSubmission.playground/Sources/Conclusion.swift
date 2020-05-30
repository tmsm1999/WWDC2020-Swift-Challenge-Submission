import Foundation
import UIKit
import SpriteKit

class Conclusion: UIViewController {
    
    override func loadView() {
        
        let circlesGame = CircleCodeQuote()
        
        let view = SKView(frame: CGRect(x: 0, y: 0, width: 375, height: 667))
        view.presentScene(circlesGame)
        
        self.view = view
    }
}

