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

    let prevButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("◀️", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        return button
    }()

    let nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("▶️", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        return button
    }()

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

        /*
        let p = pages[3]
        pageViewController.setViewControllers([p], direction: .forward, animated: false, completion: { _ in
            (p as! Page).transitioned()
        })
        */

        if let firstPage = pages.first {
            pageViewController.setViewControllers([firstPage], direction: .forward, animated: false, completion: nil)
        }

        self.pageViewController = pageViewController

        setupViews()
    }

    private func setupViews() {
        self.view.addSubview(prevButton)
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        prevButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0).isActive = true
        prevButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40.0).isActive = true
        prevButton.addTarget(self, action: #selector(goToPrevPage), for: .touchUpInside)
    
        self.view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
        nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40.0).isActive = true
        nextButton.addTarget(self, action: #selector(goToNextPage), for: .touchUpInside)
    }

    @objc private func goToPrevPage() {
        guard
            let pageViewController = self.pageViewController,
            let current = pageViewController.viewControllers?.first,
            let prevPage = pageViewController.dataSource?.pageViewController(pageViewController, viewControllerBefore: current) else {
                return
        }
        pageViewController.setViewControllers([prevPage], direction: .reverse, animated: true, completion: { completed in
            if let p = prevPage as? Page, completed {
                p.transitioned()
            }
        })
    }

    @objc private func goToNextPage() {
        guard
            let pageViewController = self.pageViewController,
            let current = pageViewController.viewControllers?.first,
            let nextPage = pageViewController.dataSource?.pageViewController(pageViewController, viewControllerAfter: current) else {
                return
        }

        pageViewController.setViewControllers([nextPage], direction: .forward, animated: true, completion: { completed in
            if let p = nextPage as? Page, completed {
                if self.pages.count - 1 == self.pages.firstIndex(of: nextPage) {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.prevButton.alpha = 0.0
                        self.nextButton.alpha = 0.0
                    })
                }
                p.transitioned()
            }
        })
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
        if self.pages.count - 1 == self.pages.firstIndex(of: vc) {
            UIView.animate(withDuration: 0.2, animations: {
                self.prevButton.alpha = 0.0
                self.nextButton.alpha = 0.0
            })
        } else {
            UIView.animate(withDuration: 0.1, animations: {
                self.prevButton.alpha = 1.0
                self.nextButton.alpha = 1.0
            })
        }
        page.transitioned()
    }
}
