import UIKit

class Page02ViewController: UIViewController {

    @IBOutlet weak var label01: UILabel!
    @IBOutlet weak var label02: UILabel!
    @IBOutlet weak var handLabel: UILabel!

    var timer: Timer?
    var counter = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.label01.alpha = 0.0
        self.label01.transform = CGAffineTransform(translationX: 0.0, y: 20.0)
        self.label02.alpha = 0.0
        self.label02.transform = CGAffineTransform(translationX: 0.0, y: 20.0)
        self.handLabel.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.timer?.invalidate()
    }

    fileprivate func startWaveHand() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { t in
            let rad: CGFloat
            if self.counter % 2 == 0 {
                rad = CGFloat.pi / 6
            } else {
                rad = -CGFloat.pi / 8
            }
            self.handLabel.transform = CGAffineTransform(translationX: 0.0, y: 20.0)
                .rotated(by: rad)
                .translatedBy(x: 0.0, y: -20.0)
            self.counter += 1
        }
    }
}

extension Page02ViewController: Page {
    func transitioned() {
        UIView.animate(
            withDuration: 1.0,
            delay: 1.0,
            animations: {
                self.label01.alpha = 1.0
                self.label01.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
            },
            completion: nil)
        UIView.animate(
            withDuration: 1.0,
            delay: 2.0,
            animations: {
                self.label02.alpha = 1.0
                self.label02.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
            },
            completion: nil)
        UIView.animate(
            withDuration: 1.0,
            delay: 3.0,
            usingSpringWithDamping: 0.24,
            initialSpringVelocity: 0.0,
            options: .beginFromCurrentState,
            animations: {
                self.handLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            },
            completion: { completed in
                if completed {
                    self.startWaveHand()
                }
            })
    }
}
