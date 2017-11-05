//
//  LandingVC.swift
//  ScrollViewMore
//
//  Created by Bassyouni on 9/28/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit

class LandingVC: UIViewController, UIScrollViewDelegate {
    
    //MARK: - iboutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    
    //MARK: - variables
    let parkour = ["title":"Parkour","quote":"\"Parkour is never meant to be a competitive sport, but more of a training technique for the body and mind.\" - Jason Jones" , "image":"1"]
    
    let mma = ["title":"MMA","quote":"\"A fighter with heart will almost always win out against a fighter with skill but now will\" - Chuck Liddell" , "image":"2"]
    
    let streetWorkout = ["title":"Street Workout","quote":"\"Long term consistency trumps short term intensity\" - Bruce Lee" , "image":"3"]
    
    var gamesArray = [Dictionary<String,String>]()
    
    var viewBoundsWidth: CGFloat!
    
    //MARK: - viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewBoundsWidth = self.view.bounds.size.width
        scrollView.delegate = self
        
        gamesArray = [parkour, mma, streetWorkout]
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(gamesArray.count), height: self.view.bounds.height)
        
        loadGamesInScrollView()
    }
    

    
    //MARK: - loadGamesInScrollView
    func loadGamesInScrollView()
    {
        for (index, game) in gamesArray.enumerated()
        {
            if let gameView = Bundle.main.loadNibNamed("GameViewSB", owner: self, options: nil)?.first as? GameView
            {
                gameView.imageView.image = UIImage(named: game["image"]!)
                gameView.titleLabel.text = game["title"]
                gameView.quoteLabel.text = game["quote"]
                scrollView.addSubview(gameView)
                //gameView.frame.size.width = 400 //self.view.bounds.size.width
                gameView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
            }
        }
        
        
    }
    
    //MARK: - scrollView delegete methods
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(page)

        if Int(page) == gamesArray.count - 1
        {
            skipBtn.isHidden = true
            nextBtn.setTitle("FINISH", for: .normal)
        }
        else
        {
            skipBtn.isHidden = false
            nextBtn.setTitle("NEXT", for: .normal)
        }
        
    }
    
    //MARK: - ibactions
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        let offset = self.view.bounds.size.width + self.scrollView.contentOffset.x
        if offset < scrollView.contentSize.width
        {
            scrollView.setContentOffset(CGPoint(x: offset , y: 0), animated: true)
        }
        else
        {
            //to not show this view again
            UserDefaults.standard.set("true", forKey: "isFirstTime")
            performSegue(withIdentifier: "LoginVC", sender: nil)
        }
        

    }

    @IBAction func skipBtnPressed(_ sender: Any) {
        //to not show this view again
        UserDefaults.standard.set("true", forKey: "isFirstTime")
        performSegue(withIdentifier: "LoginVC", sender: nil)
    }



}

