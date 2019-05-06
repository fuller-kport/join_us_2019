import UIKit

enum Quarter {
    case topRight
    case bottomRight
    case bottomLeft
    case topLeft
}

func shuffledQuarters() -> [Quarter] {
    var quarters: [Quarter] = [
        .topRight, .topRight,
        .bottomRight, .bottomRight,
        .bottomLeft, .bottomLeft,
        .topLeft, .topLeft
    ]
    var shuffled = [Quarter]()
    for _ in 0..<quarters.count {
        let i = Int(arc4random_uniform(UInt32(quarters.count)))
        shuffled.append(quarters[i])
        quarters.remove(at: i)
    }
    return shuffled
}

struct FlipOptions: OptionSet {
    let rawValue: Int
    static let horizontally = FlipOptions(rawValue: 1 << 0)
    static let vertically = FlipOptions(rawValue: 1 << 1)
}

func flipOptions(`for` quarter: Quarter) -> FlipOptions {
    var flipOptions: FlipOptions = []
    if quarter == .bottomLeft || quarter == .topLeft {
        flipOptions.insert(.horizontally)
    }
    
    if quarter == .bottomLeft || quarter == .bottomRight {
        flipOptions.insert(.vertically)
    }
    return flipOptions
}

func randomChangeVector(flipOptions: FlipOptions, maxValue: Int) -> CGVector {
    let x = CGFloat(arc4random_uniform(UInt32(maxValue)))
    let y = CGFloat(arc4random_uniform(UInt32(maxValue)))
    let sx: CGFloat = flipOptions.contains(.horizontally) ? -1.0 : 1.0
    let sy: CGFloat = flipOptions.contains(.vertically) ? -1.0 : 1.0
    return CGVector(dx: x * sx, dy: y * sy)
}

class BasicFirework: Firework {

    var origin: CGPoint
    var scale: CGFloat
    var sparkSize: CGSize

    private var quarters: [Quarter] = []

    init(origin: CGPoint, sparkSize: CGSize, scale: CGFloat) {
        self.origin = origin
        self.scale = scale
        self.sparkSize = sparkSize
        self.quarters = shuffledQuarters()
    }

    func sparkView(at index: Int) -> SparkView {
        let data = SparkViewData(size: self.sparkSize, index: index)
        return createSparkView(with: data)
    }

    func sparkTrajectory(at index: Int) -> SparkTrajectory {
        let q = self.quarters[index]
        let ops = flipOptions(for: q)
        let changeVector = randomChangeVector(flipOptions: ops, maxValue: 10)
        let sparkOrigin = self.origin.adding(vector: changeVector)

        return randomTrajectory(flipOptions: ops)
            .scale(by: self.scale)
            .shift(to: sparkOrigin)
    }
}
