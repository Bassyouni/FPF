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
    
    deinit {
        print("GuestVc deinit")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let backBtn = UIBarButtonItem(title: "Login", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.backBtnPressed))
//        navigationItem.leftBarButtonItem = backBtn

        
        aboutUsVC = storyboard?.instantiateViewController(withIdentifier: "AboutUsVC")
        fpfCoursesVC = storyboard?.instantiateViewController(withIdentifier: "FPFCoursesGuest")
        
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width:(self.view.bounds.size.width * 2) , height: 1)

        
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = true
        
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
                scrollView.setContentOffset( CGPoint(x: 0 , y: 0) , animated: true)
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
                scrollView.setContentOffset( CGPoint(x: self.view.bounds.size.width , y: 0 ) , animated: true)
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
        }
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

    @IBAction func backBtnPressed(sender_: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
