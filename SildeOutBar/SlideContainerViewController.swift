//
//  SlideContainerViewController.swift
//  SildeOutBar
//
//  Created by Krrish on 27/06/18.
//  Copyright © 2018 Keshav Raj. All rights reserved.
//

import UIKit

class SlideContainerViewController: UIViewController {
    
    private var sideViewController: UIViewController!
    private var mainViewController: UIViewController!
    private var overlap: CGFloat!
    private var scrollView: UIScrollView!
    private var isLayoutForFirstTime = true
    
    required init(coder aDecoder: NSCoder) {
        assert(false, "Use init(leftViewController:mainViewController:overlap:)")
        super.init(coder: aDecoder)!
    }
    
    init(sideViewController: UIViewController, mainViewController: UIViewController, overlap: CGFloat) {
        self.sideViewController = sideViewController
        self.mainViewController = mainViewController
        self.overlap = overlap
        super.init(nibName: nil, bundle: nil)
        
        addScrollView()
        setViewControllers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isLayoutForFirstTime {
           closeSideBar(false)
            isLayoutForFirstTime = false
        }
    }
    
    private func isSideBarOpen() -> Bool {
        return scrollView.contentOffset.x == 0
    }
    
    private func closeSideBar(_ animated: Bool) {
        scrollView.setContentOffset(CGPoint(x:sideViewController.view.bounds.width, y: 0), animated: animated)
    }
    
    private func openSideBar(_ animated: Bool) {
        scrollView.setContentOffset(CGPoint.zero, animated: animated)
    }
    
    func toggleSideBar(_ animated: Bool) {
        isSideBarOpen() ? closeSideBar(animated) : openSideBar(animated)
    }
    
    private func addScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        view.addSubview(scrollView)
        let views:[String: UIView] = [
            "scrollView": scrollView
        ]
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: [], metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|", options: [], metrics: nil, views: views)
        NSLayoutConstraint.activate(horizontalConstraints + verticalConstraints)
    }
    
    private func setViewControllers() {
        addViewController(sideViewController)
        addViewController(mainViewController)
        addShadowTo(mainViewController.view)
        let views:[String: UIView] = [
            "sideView": sideViewController.view,
            "mainView": mainViewController.view,
            "view": view
        ]
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[sideView(==view)]|", options: [], metrics: nil, views: views)
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[sideView][mainView(==view)]|", options: [.alignAllTop, .alignAllBottom], metrics: nil, views: views)
        let widthConstraint = NSLayoutConstraint(item: sideViewController.view, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: -overlap)
        NSLayoutConstraint.activate(verticalConstraints + horizontalConstraints + [widthConstraint])
    }
    
    private func addViewController(_ viewController: UIViewController) {
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(viewController.view)
        addChildViewController(viewController)
        viewController.didMove(toParentViewController: self)
    }
    
    private func addShadowTo(_ view: UIView) {
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowRadius = 3.0
        view.layer.shadowOpacity = 1.0
        view.layer.shadowOffset = CGSize.zero
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
