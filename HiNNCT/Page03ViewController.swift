import UIKit

class Page03ViewController: UIViewController {

    @IBOutlet weak var label01: UILabel!
    @IBOutlet weak var label02: UILabel!
    @IBOutlet weak var thinkingFaceLabel: UILabel!

    @IBOutlet weak var apparatus01: UILabel!
    @IBOutlet weak var apparatus02: UILabel!
    @IBOutlet weak var apparatus03: UILabel!
    @IBOutlet weak var apparatus04: UILabel!
    @IBOutlet weak var apparatus05: UILabel!
    @IBOutlet weak var apparatus06: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.label01.alpha = 0.0
        self.label01.transform = CGAffineTransform(translationX: 0.0, y: 20.0)
        self.label02.alpha = 0.0
        self.label02.transform = CGAffineTransform(translationX: 0.0, y: 20.0)
        self.thinkingFaceLabel.transform = CGAffineTransform(
            scaleX: 0.01,
            y: 0.01
        )

        [apparatus01,
         apparatus02,
         apparatus03,
         apparatus04,
         apparatus05,
         apparatus06]
            .forEach { label in
                label?.transform = CGAffineTransform(
                    scaleX: 0.01,
                    y: 0.01
                )
            }
    }
}

extension Page03ViewController: Page {
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
            withDuration: 0.3,
            delay: 4.5,
            options: [.beginFromCurrentState, .curveEaseOut],
            animations: {
                self.thinkingFaceLabel.transform = CGAffineTransform(
                    scaleX: 1.0,
                    y: 1.0
                )
            },
            completion: { completed in
                if completed {
                    UIView.animate(
                        withDuration: 1.0,
                        delay: 0.0,
                        options: [.autoreverse, .repeat, .curveEaseInOut],
                        animations: {
                            self.thinkingFaceLabel.transform = CGAffineTransform(
                                rotationAngle: CGFloat.pi / 12
                            )
                        },
                        completion: nil)
                }
            })

        [apparatus01,
         apparatus02,
         apparatus03,
         apparatus04,
         apparatus05,
         apparatus06]
            .enumerated()
            .forEach { item in
                UIView.animate(
                    withDuration: 0.3,
                    delay: 2.5 + 0.15 * Double(item.offset),
                    options: [.beginFromCurrentState, .curveEaseOut],
                    animations: {
                        item.element.transform = CGAffineTransform(
                            scaleX: 1.0,
                            y: 1.0
                        )
                    },
                    completion: nil)
            }
    }
}
