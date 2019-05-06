import UIKit

class Page04ViewController: UIViewController {

    @IBOutlet weak var label01: UILabel!
    @IBOutlet weak var label02: UILabel!
    @IBOutlet weak var label03: UILabel!
    @IBOutlet weak var dancingLabel: UILabel!
    
    var timer: Timer?
    var counter = 0

    private let fireworkController = FireworkController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.label01.alpha = 0.0
        self.label01.transform = CGAffineTransform(translationX: 0.0, y: 20.0)

        self.label02.alpha = 0.0
        self.label02.transform = CGAffineTransform(translationX: 0.0, y: 20.0)

        self.label03.alpha = 0.0
        self.label03.transform = CGAffineTransform(translationX: 0.0, y: 20.0)

        self.dancingLabel.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.timer?.invalidate()
    }

    private func startLaunchFireworks() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { t in
            if self.counter % 2 == 0 {
                self.dancingLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            } else {
                self.dancingLabel.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            }

            if Int.random(in: 0...1) == 0 {
                let maxX = UInt32(exactly: self.view.bounds.maxX) ?? 0
                let maxY = UInt32(exactly: self.view.bounds.maxY) ?? 0
                let x = CGFloat(arc4random_uniform(maxX))
                let y = CGFloat(arc4random_uniform(maxY))
                let p = CGPoint(x: x, y: y)
                self.fireworkController.addFirework(origin: p, superView: self.view)
            }

            self.counter += 1
        }
    }
}

extension Page04ViewController: Page {
    func transitioned() {
        UIView.animate(
            withDuration: 1.0,
            delay: 0.5,
            animations: {
                self.label01.alpha = 1.0
                self.label01.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
            },
            completion: nil)
        UIView.animate(
            withDuration: 1.0,
            delay: 1.5,
            animations: {
                self.label02.alpha = 1.0
                self.label02.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
            },
            completion: nil)
        UIView.animate(
            withDuration: 1.0,
            delay: 3,
            animations: {
                self.label03.alpha = 1.0
                self.label03.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
            },
            completion: nil)
        UIView.animate(
            withDuration: 1.0,
            delay: 4,
            animations: {
                self.dancingLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            },
            completion: { completed in
                self.startLaunchFireworks()
            })
    }
}
