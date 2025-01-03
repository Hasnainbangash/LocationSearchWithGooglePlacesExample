//
//  ViewController.swift
//  LocationSearchWithGooglePlacesExample
//
//  Created by Elexoft on 31/12/2024.
//

import UIKit
import MapKit

class ViewController: UIViewController, UISearchResultsUpdating {

    let mapView = MKMapView()
    
    let searchVC = UISearchController(searchResultsController: ResultsViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Maps"
        view.addSubview(mapView)
        
        searchVC.searchBar.backgroundColor = .secondarySystemBackground
        searchVC.searchResultsUpdater = self
        navigationItem.searchController = searchVC
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.frame.size.width,
            height: view.frame.size.height - view.safeAreaInsets.top
        )
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty, let resultVC = searchController.searchResultsController as? ResultsViewController else {
            return
        }
        
        resultVC.delegate = self
        
        GooglePlacesManager.shared.findPlaces(query: query) { result in
            switch result {
            case .success(let places):
                print(places)
                DispatchQueue.main.async {
                    resultVC.update(with: places)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }

}

extension ViewController: ResultsViewControllerDelegate {
    func didTapPlace(with coordinates: CLLocationCoordinate2D) {
        
        // Get rid of the keyboard by use this
        searchVC.searchBar.resignFirstResponder()
        
        // Code to remove the searching
        searchVC.dismiss(animated: true, completion: nil)
        
        // Remove all map pins
        let annotations =  mapView.annotations
        mapView.removeAnnotations(annotations)
        
        // Add a map pin
        let pin = MKPointAnnotation()
        pin.coordinate = coordinates
        mapView.addAnnotation(pin)
        mapView.setRegion(MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)), animated: true)
        
    }
}
