//
//  PageReadViewController.swift
//  ComiX
//
//  Created by Alexis on 11/24/16.
//  Copyright © 2016 Alexis. All rights reserved.
//

import UIKit

class PageReadViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    var pagesViewer    : UIPageViewController!
    var comicsPages    : [UIViewController]!
    var startPageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillViews()
        addPageViewController()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let ind = comicsPages.index(of: viewController) else{
            return nil
        }
        let previousIndex = ind - 1
        guard previousIndex >= 0 else {
            return comicsPages.last
        }
        guard previousIndex < comicsPages.count else {
            return nil
        }
        return comicsPages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let ind = comicsPages.index(of: viewController) else{
            return nil
        }
        let nextIndex = ind + 1
        guard nextIndex < comicsPages.count else {
            return comicsPages.first
        }
        guard comicsPages.count > nextIndex else {
            return nil
        }
        return comicsPages[nextIndex]
    }
    
}

fileprivate extension PageReadViewController {
    
    func fillViews() {
        comicsPages = [UIViewController]()
        let pp = PageViewController()
        pp.view.backgroundColor = UIColor.gray
        comicsPages.append(pp)
        let pp1 = PageViewController()
        pp1.view.backgroundColor = UIColor.cyan
        comicsPages.append(pp1)
    }
    
    func addPageViewController(){
        pagesViewer = UIPageViewController()
        pagesViewer.delegate = self
        pagesViewer.dataSource = self
        pagesViewer.setViewControllers([comicsPages[startPageIndex]], direction: .forward, animated: true, completion: nil)
        pagesViewer.view.backgroundColor = UIColor.yellow
        self.view.addSubview(pagesViewer.view)
    }
}
