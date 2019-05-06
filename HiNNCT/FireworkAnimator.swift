import UIKit

struct FireworkAnimator {

    func animate(spark: FireworkSpark, duration: TimeInterval) {
        spark.view.isHidden = false

        CATransaction.begin()

        /* Position */
        let positionAnim = CAKeyframeAnimation(keyPath: "position")
        positionAnim.path = spark.trajectory.path.cgPath
        positionAnim.calculationMode = CAAnimationCalculationMode.linear
        positionAnim.rotationMode = CAAnimationRotationMode.rotateAuto
        positionAnim.duration = duration

        /* Scale */
        let minScale = 0.5 + CGFloat(arc4random_uniform(3)) / 10.0
        let maxScale = 1.0 + CGFloat(arc4random_uniform(7)) / 10.0

        let fromTransform = CATransform3DIdentity
        let byTransform = CATransform3DScale(CATransform3DIdentity, maxScale, maxScale, maxScale)
        let toTransform = CATransform3DScale(CATransform3DIdentity, minScale, minScale, minScale)
        let transformAnim = CAKeyframeAnimation(keyPath: "transform")
        transformAnim.values = [
            NSValue(caTransform3D: fromTransform),
            NSValue(caTransform3D: byTransform),
            NSValue(caTransform3D: toTransform)
        ]
        transformAnim.duration = duration
        transformAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        spark.view.layer.transform = toTransform

        // Opacity
        let opacityAnim = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnim.values = [1.0, 0.0]
        opacityAnim.keyTimes = [0.95, 0.98]
        opacityAnim.duration = duration
        spark.view.layer.opacity = 0.0

        // Group
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnim, transformAnim, opacityAnim]
        groupAnimation.duration = duration

        spark.view.layer.add(groupAnimation, forKey: "spark-animation")

        CATransaction.commit()
    }
}
