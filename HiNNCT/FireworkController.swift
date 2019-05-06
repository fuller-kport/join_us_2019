import UIKit

class FireworkController {

    let animator = FireworkAnimator()

    func addFirework(
        origin: CGPoint,
        superView: UIView,
        sparksCount: Int = 8,
        sparkSize: CGSize = CGSize(width: 7, height: 7),
        scale: CGFloat = 200.0) {

        let firework = self.createFirework(
            at: origin,
            sparkSize: sparkSize,
            scale: scale)

        for sparkIndex in 0..<sparksCount {
            let spark = firework.spark(at: sparkIndex)
            spark.view.isHidden = true
            superView.addSubview(spark.view)
            // let zIndexChange: CGFloat = arc4random_uniform(2) == 0 ? -1 : 1
            // spark.view.layer.zPosition = superView.layer.zPosition + zIndexChange
            self.animator.animate(spark: spark, duration: 1.0)
        }
    }

    func createFirework(at origin: CGPoint, sparkSize: CGSize, scale: CGFloat) -> Firework {
        return BasicFirework(origin: origin, sparkSize: sparkSize, scale: scale)
    }
}
