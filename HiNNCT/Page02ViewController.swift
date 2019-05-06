import UIKit

class Page02ViewController: UIViewController {

    @IBOutlet weak var label01: UILabel!
    @IBOutlet weak var label02: UILabel!
    
    override func viewDidLoad() {
        self.label01.alpha = 0.0
        self.label02.alpha = 0.0
    }
}

extension Page02ViewController: Page {
    func transitioned() {
        UIView.animate(
            withDuration: 1.0,
            delay: 0.0,
            animations: {
                self.label01.alpha = 1.0
            },
            completion: nil)
        UIView.animate(
            withDuration: 1.0,
            delay: 0.4,
            animations: {
                self.label02.alpha = 1.0
            },
            completion: nil)

    }
}
