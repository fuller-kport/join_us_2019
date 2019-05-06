import UIKit

class ViewController: UIViewController {

    var pageViewController: UIPageViewController?

    lazy var pages: [UIViewController] = {
        let storyboard = UIStoryboard(name: "Pages", bundle: nil)
        return [
            storyboard.instantiateViewController(withIdentifier: "Page01"),
            storyboard.instantiateViewController(withIdentifier: "Page02"),
            storyboard.instantiateViewController(withIdentifier: "Page03"),
            storyboard.instantiateViewController(withIdentifier: "Page04")
        ]
    }()

    var lastPendingViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )

        pageViewController.dataSource = self
        pageViewController.delegate = self

        self.addChild(pageViewController)
        self.view.addSubview(pageViewController.view)

        pageViewController.view.frame = self.view.bounds
        pageViewController.didMove(toParent: self)

        if let firstPage = pages.first {
            pageViewController.setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
        }

        self.pageViewController = pageViewController
    }
}

extension ViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController) else {
            return nil
        }

        let prevIndex = index - 1

        guard prevIndex >= 0 else {
            return nil
        }

        return pages[prevIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController) else {
            return nil
        }

        let nextIndex = index + 1

        guard nextIndex < pages.count else {
            return nil
        }

        return pages[nextIndex]
    }
}

extension ViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        self.lastPendingViewController = pendingViewControllers.first
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let vc = self.lastPendingViewController, completed else {
            return
        }
        guard let page = vc as? Page else {
            return
        }
        page.transitioned()
    }
}
