import PlaygroundSupport
import SpriteKit
import UIKit

public class Introduction: UIViewController {
    
    public override func loadView() {

        let view = SKView()
        view.ignoresSiblingOrder = true
        view.presentScene(HelloScene())

        self.view = view
    }
}
