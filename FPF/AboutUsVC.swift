//
//  AboutUsVC.swift
//  FPF
//
//  Created by Bassyouni on 9/30/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit
import MapKit

class AboutUsVC: UIViewController{
    
     @IBOutlet weak var mapView: MKMapView!
    
    deinit {
        print("aboutusVC deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //mapView.delegate = self
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "menuBtn"), for: UIControlState.normal)
        button.addTarget(self, action:#selector(self.menuBtnPressed(_:)), for: UIControlEvents.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30) //CGRectMake(0, 0, 30, 30)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = barButton

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        centerMapOnLocation()
    }
    
    @IBAction func menuBtnPressed(_ sender: Any)
    {
        self.menuContainerViewController.toggleLeftSideMenuCompletion({})
    }
    
    func centerMapOnLocation()
    {
        let location = CLLocation(latitude: 30.1104975, longitude: 31.3117629)
    
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude:location.coordinate.longitude)
        annotation.coordinate = centerCoordinate
        annotation.title = "36 Makram Ebeid st. Nasr city, Cairo, Egypt"
        mapView.addAnnotation(annotation)
        
        let latDelta:CLLocationDegrees = 0.05
        
        let lonDelta:CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let region = MKCoordinateRegionMake(location.coordinate, span)
        
        mapView.setRegion(region, animated: false)


    }
    
    @IBAction func facebookBtnPressed(_ sender: Any) {
        UIApplication.tryURL(urls: ["fb://facebook.com/fpfegypt","https://www.facebook.com/fpfegypt"])
    }
    
    @IBAction func telephoneBtnPressed(_ sender: Any) {
    }
    
    //TODO: phone and facebook on about use implimntaion

    

}
