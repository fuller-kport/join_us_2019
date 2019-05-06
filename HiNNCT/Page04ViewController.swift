import UIKit

class Page04ViewController: UIViewController {

    @IBOutlet weak var label01: UILabel!
    @IBOutlet weak var label02: UILabel!
    @IBOutlet weak var label03: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.label01.alpha = 0.0
        self.label01.transform = CGAffineTransform(translationX: 0.0, y: 20.0)
        self.label02.alpha = 0.0
        self.label02.transform = CGAffineTransform(translationX: 0.0, y: 20.0)
        self.label03.alpha = 0.0
        self.label03.transform = CGAffineTransform(translationX: 0.0, y: 20.0)
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
    }
}
