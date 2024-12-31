//
//  ViewController.swift
//  LocationSearchWithGooglePlacesExample
//
//  Created by Elexoft on 31/12/2024.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Maps"
        view.addSubview(mapView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
    }

}

