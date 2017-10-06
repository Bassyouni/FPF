//
//  GuestVC.swift
//  FPF
//
//  Created by Bassyouni on 10/2/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit

class GuestVC: UIViewController, UIScrollViewDelegate {
    
    var aboutUsVC: UIViewController!
    var fpfCoursesVC: UIViewController!

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var conatinorView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutUsVC = storyboard?.instantiateViewController(withIdentifier: "AboutUsVC")
        fpfCoursesVC = storyboard?.instantiateViewController(withIdentifier: "FPFCourses")
        
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width:(self.view.bounds.size.width * 2) , height: 1)

        
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = true
        
        
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addChildViewController(fpfCoursesVC!)
        self.scrollView.addSubview((fpfCoursesVC?.view)!)
        fpfCoursesVC?.willMove(toParentViewController: self)

        fpfCoursesVC.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        fpfCoursesVC.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        fpfCoursesVC.view.translatesAutoresizingMaskIntoConstraints = false
       fpfCoursesVC.view.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: self.view.bounds.size.width).isActive = true
        fpfCoursesVC.view.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0).isActive = true
        fpfCoursesVC.view.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        fpfCoursesVC.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true

        fpfCoursesVC.view.frame.origin = CGPoint(x: self.view.bounds.size.width, y: 0)



        
    }
    
    @IBAction func segmentedChange(_ sender: Any) {
        
        if segmentedControl.selectedSegmentIndex == 0
        {
            scrollView.setContentOffset( CGPoint(x: 0 , y: 0) , animated: true)
        }
        else
        {
            scrollView.setContentOffset( CGPoint(x: self.view.bounds.size.width , y: 0 ) , animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        if page < 1
        {
            segmentedControl.selectedSegmentIndex = 0
        }
        else
        {
            segmentedControl.selectedSegmentIndex = 1
        }
    }

}
