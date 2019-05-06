import UIKit

/*
 mimic from http://szulctomasz.com/programming-blog/2018/09/add-fireworks-and-sparks-to-a-uiview/
 */

typealias FireworkSpark = (view: SparkView, trajectory: SparkTrajectory)

protocol Firework {
    var origin: CGPoint { get set }
    var scale: CGFloat { get set }
    var sparkSize: CGSize { get set }

    func sparkView(at index: Int) -> SparkView
    func sparkTrajectory(at index: Int) -> SparkTrajectory
}

extension Firework {
    func spark(at index: Int) -> FireworkSpark {
        return FireworkSpark(self.sparkView(at: index), self.sparkTrajectory(at: index))
    }
}
