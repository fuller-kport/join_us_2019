import UIKit

struct SparkTrajectory {
    var points: [CGPoint]
    var path: UIBezierPath {
        let p0 = self.points[0]
        let p1 = self.points[1]
        let p2 = self.points[2]
        let p3 = self.points[3]
        let path = UIBezierPath()
        path.move(to: p0)
        path.addCurve(to: p3, controlPoint1: p1, controlPoint2: p2)
        return path
    }

    init(
        _ x0: CGFloat, _ y0: CGFloat,
        _ x1: CGFloat, _ y1: CGFloat,
        _ x2: CGFloat, _ y2: CGFloat,
        _ x3: CGFloat, _ y3: CGFloat) {

        let p0 = CGPoint(x: x0, y: y0)
        let p1 = CGPoint(x: x1, y: y1)
        let p2 = CGPoint(x: x2, y: y2)
        let p3 = CGPoint(x: x3, y: y3)

        self.points = [p0, p1, p2, p3]
    }
}

extension SparkTrajectory {
    func scale(by value: CGFloat) -> SparkTrajectory {
        var copy = self
        (0..<self.points.count).forEach {
            copy.points[$0].multiply(by: value)
        }
        return copy
    }

    func flip() -> SparkTrajectory {
        var copy = self
        (0..<self.points.count).forEach {
            copy.points[$0].x *= -1
        }
        return copy
    }

    func shift(to point: CGPoint) -> SparkTrajectory {
        var copy = self
        let vector = CGVector(dx: point.x, dy: point.y)
        (0..<self.points.count).forEach { copy.points[$0].add(vector: vector) }
        return copy
    }
}
