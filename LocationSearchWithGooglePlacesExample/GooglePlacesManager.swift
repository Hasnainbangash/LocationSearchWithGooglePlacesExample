//
//  GooglePlacesManager.swift
//  LocationSearchWithGooglePlacesExample
//
//  Created by Elexoft on 31/12/2024.
//

import Foundation
import GooglePlaces

final class GooglePlacesManager {
    // Shared instanse of this class
    static let shared = GooglePlacesManager()
    
    // Client for google places
    private let client = GMSPlacesClient.shared()
    
    // Privitiaze the initilalizer
    private init() {}
    
    public func setup() {
        // Provode the API key to the Google places client
        GMSPlacesClient.provideAPIKey("AIzaSyD6-djNbx6qEiPJm0uzYx-pzBbrqItkJnU")
    }
    
    public func findPlaces(query: String, completion: @escaping (Result<[String], Error>)) -> Void {
        
        let filter = GMSAutocompleteFilter()
        filter.type = .geocode
        
        client.findAutocompletePredictions(fromQuery: query, filter: filter, sessionToken: nil) { results, error in
            guard let results = results, error == nil else {return}
        }
    }
}
