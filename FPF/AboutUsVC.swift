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

    override func viewDidLoad() {
        super.viewDidLoad()
        //mapView.delegate = self

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        centerMapOnLocation()
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

    

}
