//
//  PageVC.swift
//  WeatherGift
//
//  Created by Chloe Cheng on 10/14/19.
//  Copyright © 2019 Chloe Cheng. All rights reserved.
//

import UIKit

class PageVC: UIPageViewController {

    var currentPage = 0
    var locationsArray = ["Local City", "Chestnut Hill, MA", "Synday, Australia", "Shenzhen, China"]
    var pageControl: UIPageControl!
    var listButton: UIButton!
    var barButtonWidth: CGFloat = 44
    var barButtonHeight: CGFloat = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dataSource = self
        
        setViewControllers([createDetailVC(forPage: 0)], direction: .forward, animated: false, completion: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configurePageControll()
        configureListButton()
    }
    
    //MARK:- UI Configure Methods
    func configurePageControll() {
        let pageControllHeight: CGFloat = barButtonHeight
        let pageControllWidth: CGFloat = view.frame.width - (barButtonWidth * 2)
        
        let safeHeight = view.frame.height - view.safeAreaInsets.bottom
        
        pageControl = UIPageControl(frame: CGRect(x: (view.frame.width - pageControllWidth) / 2, y: safeHeight - pageControllHeight, width: pageControllWidth, height: pageControllHeight))
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.numberOfPages = locationsArray.count
        pageControl.currentPage = currentPage
        pageControl.addTarget(self, action: #selector(pageControlPressed), for: .touchUpInside)
        
        view.addSubview(pageControl)
    }
    
    func configureListButton() {
        let safeHeight = view.frame.height - view.safeAreaInsets.bottom
        
        listButton = UIButton(frame: CGRect(x: view.frame.width - barButtonWidth, y: safeHeight - barButtonHeight, width: barButtonWidth, height: barButtonHeight))
        listButton.setImage(UIImage(named: "listbuttons"), for: .normal)
        listButton.setImage(UIImage(named: "listbuttons-highlighted"), for: .highlighted)
        listButton.addTarget(self, action: #selector(segueToLocationVC), for: .touchUpInside)
        
        view.addSubview(listButton)
    }
    
    @objc func segueToLocationVC() {
        print("Hey! You Clicked Me!")
    }
    
    //MARK:- Create View Controller for UIPageViewController
    func createDetailVC(forPage page: Int) -> DetailVC {
        
        //Error Check
        currentPage = min(max(0, page), locationsArray.count - 1)
        
        let detailVC = storyboard!.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        
        detailVC.locationsArray = locationsArray
        detailVC.currentPage = currentPage
        
        return detailVC
        
    }

}

extension PageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //Error Check
        if let currentViewController = viewController as? DetailVC {
            if currentViewController.currentPage < locationsArray.count - 1 {
                return createDetailVC(forPage: currentViewController.currentPage + 1)
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as? DetailVC {
            if currentViewController.currentPage > 0 {
                return createDetailVC(forPage: currentViewController.currentPage - 1)
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentViewController = pageViewController.viewControllers?[0] as? DetailVC {
            pageControl.currentPage = currentViewController.currentPage
        }
    }
    
    @objc func pageControlPressed() {
        guard let currentViewController = self.viewControllers?[0] as? DetailVC else {return}
            currentPage = currentViewController.currentPage
            if pageControl.currentPage < currentPage {
                setViewControllers([createDetailVC(forPage: pageControl.currentPage)], direction: .reverse, animated: true, completion: nil)
            } else if pageControl.currentPage > currentPage {
                setViewControllers([createDetailVC(forPage: pageControl.currentPage)], direction: .forward, animated: true, completion: nil)
            }
        }
    }
