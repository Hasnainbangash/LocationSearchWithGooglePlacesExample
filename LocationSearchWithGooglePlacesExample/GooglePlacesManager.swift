//
//  GooglePlacesManager.swift
//  LocationSearchWithGooglePlacesExample
//
//  Created by Elexoft on 31/12/2024.
//

import Foundation
import GooglePlaces

struct Place {
    let name: String
    let identifier: String
}

final class GooglePlacesManager {
    // Shared instanse of this class
    static let shared = GooglePlacesManager()
    
    // Client for google places
    private let client = GMSPlacesClient.shared()
    
    // Privitiaze the initilalizer
    private init() {}
    
    // Create a custom enum
    enum PlacesError: Error {
        case failedToFind
    }
    
    public func findPlaces(query: String, completion: @escaping (Result<[Place], Error>) -> Void) {
        
        // Create a custom filter
        let filter = GMSAutocompleteFilter()
        filter.type = .geocode
        
        client.findAutocompletePredictions(fromQuery: query, filter: filter, sessionToken: nil) { results, error in
            guard let results = results, error == nil else {
                completion(.failure(PlacesError.failedToFind))
                return
            }
            
            let places: [Place] = results.compactMap {
                Place(name: $0.attributedFullText.string, identifier: $0.placeID)
            }
            
            completion(.success(places))
            
        }
    }
}
