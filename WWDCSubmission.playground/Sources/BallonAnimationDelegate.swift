import Foundation
import UIKit

class BallonAnimationDelegate: NSObject, CAAnimationDelegate {
    var didFinishAnimation: (() -> Void)?
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        didFinishAnimation?()
    }
}
