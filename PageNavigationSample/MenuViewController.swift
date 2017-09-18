//
//  MenuViewController.swift
//  PageNavigationSample
//
//  Created by ishmeev on 18.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    @IBOutlet weak var redLabel: UILabel!
    
    @IBOutlet weak var greenLabel: UILabel!
    
    @IBOutlet weak var blueLabel: UILabel!
    
    lazy var redController: UIViewController = {
        let controller = UIViewController()
        controller.view.backgroundColor = UIColor.red
        return controller
    }()
    
    lazy var greenController: UIViewController = {
        let controller = UIViewController()
        controller.view.backgroundColor = UIColor.green
        return controller
    }()
    
    lazy var blueController: UIViewController = {
        let controller = UIViewController()
        controller.view.backgroundColor = UIColor.blue
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    func setupView() {
        if let pageViewController = self.childViewControllers.filter({ $0 is UIPageViewController }).first as? UIPageViewController {
            pageViewController.delegate = self
            pageViewController.dataSource = self
            pageViewController.setViewControllers([self.redController], direction: .forward, animated: false, completion: nil)
            self.highlight(label: self.redLabel)
        }
    }
    
    // MARK: UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController === self.redController {
            return nil
        } else if viewController === self.greenController {
            return self.redController
        } else if viewController === self.blueController {
            return self.greenController
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController === self.redController {
            return self.greenController
        } else if viewController === self.greenController {
            return self.blueController
        } else if viewController === self.blueController {
            return nil
        }
        return nil
    }
    
    // MARK: UIPageViewControllerDelegate
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewController = pageViewController.viewControllers?.first else { return }
        if viewController === self.redController {
            self.highlight(label: self.redLabel)
        } else if viewController === self.greenController {
            self.highlight(label: self.greenLabel)
        } else if viewController === self.blueController {
            self.highlight(label: self.blueLabel)
        }
    }
    
    // MARK: Private
    
    private func highlight(label: UILabel) {
        self.higlightIfNeeded(label: label, checkLabel: self.redLabel)
        self.higlightIfNeeded(label: label, checkLabel: self.greenLabel)
        self.higlightIfNeeded(label: label, checkLabel: self.blueLabel)
    }

    private func higlightIfNeeded(label: UILabel, checkLabel: UILabel) {
        checkLabel.textColor = checkLabel === label ? UIColor.magenta : UIColor.black
    }
}

