import UIKit

struct SparkViewData {
    let size: CGSize
    let index: Int
}

let sparkColorSet = [
    UIColor(red: 255 / 255.0, green: 75 / 255.0, blue: 84 / 255.0, alpha:1.0),
    UIColor(red: 0 / 255.0, green: 89 / 255.0, blue: 246 / 255.0, alpha:1.0),
    UIColor(red: 39 / 255.0, green: 240 / 255.0, blue: 35 / 255.0, alpha:1.0),
    UIColor(red: 153 / 255.0, green: 89 / 255.0, blue: 249 / 255.0, alpha:1.0),
    UIColor(red: 255 / 255.0, green: 185 / 255.0, blue: 30 / 255.0, alpha:1.0),
    UIColor(red: 255 / 255.0, green: 249 / 255.0, blue: 117 / 255.0, alpha:1.0),
]

func createSparkView(with data: SparkViewData) -> SparkView {
    let color = sparkColorSet[data.index % sparkColorSet.count]
    return SparkView(color: color, size: data.size)
}
