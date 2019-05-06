import Foundation

fileprivate let topRight = [
    SparkTrajectory(0.00, 0.00, 0.31, -0.46, 0.74, -0.29, 0.99, 0.12),
    SparkTrajectory(0.00, 0.00, 0.31, -0.46, 0.62, -0.49, 0.88, -0.19),
    SparkTrajectory(0.00, 0.00, 0.10, -0.54, 0.44, -0.53, 0.66, -0.30),
    SparkTrajectory(0.00, 0.00, 0.19, -0.46, 0.41, -0.53, 0.65, -0.45)
]

fileprivate let bottomRight = [
    SparkTrajectory(0.00, 0.00, 0.42, -0.01, 0.68, 0.11, 0.87, 0.44),
    SparkTrajectory(0.00, 0.00, 0.35, 0.00, 0.55, 0.12, 0.62, 0.45),
    SparkTrajectory(0.00, 0.00, 0.21, 0.05, 0.31, 0.19, 0.32, 0.45),
    SparkTrajectory(0.00, 0.00, 0.18, 0.00, 0.31, 0.11, 0.35, 0.25)
]

func randomTopRight() -> SparkTrajectory {
    let i = Int(arc4random_uniform(UInt32(topRight.count)))
    return topRight[i]
}

func randomBottomRight() -> SparkTrajectory {
    let i = Int(arc4random_uniform(UInt32(topRight.count)))
    return bottomRight[i]
}

func createSparkTrajectory() -> SparkTrajectory {
    let i = Int(arc4random_uniform(UInt32(topRight.count)))
    return topRight[i]
}

func randomTrajectory(flipOptions: FlipOptions) -> SparkTrajectory {
    let trajectory: SparkTrajectory
    if flipOptions.contains(.vertically) {
        trajectory = randomBottomRight()
    } else {
        trajectory = randomTopRight()
    }
    return flipOptions.contains(.horizontally) ? trajectory.flip() : trajectory
}
