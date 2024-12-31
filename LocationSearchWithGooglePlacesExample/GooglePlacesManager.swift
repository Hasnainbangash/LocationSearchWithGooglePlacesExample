//
//  GooglePlacesManager.swift
//  LocationSearchWithGooglePlacesExample
//
//  Created by Elexoft on 31/12/2024.
//

import Foundation
import GooglePlaces
import CoreLocation

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
        case failedToGetCoordinates
    }
    
    public func findPlaces(query: String, completion: @escaping (Result<[Place], Error>) -> Void) {
        
        // Create a custom filter
        let filter = GMSAutocompleteFilter()
        filter.type = .geocode
        
        client.findAutocompletePredictions(fromQuery: query, filter: filter, sessionToken: nil) { results, error in
            print("------------------------------------------")
            if let error = error {
                print(error)
            }
            print("------------------------------------------")
            
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
    
    public func resolveLocation(for place: Place, completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void ) {
        
        client.fetchPlace(fromPlaceID: place.identifier, placeFields: .coordinate, sessionToken: nil) { googlePlace, error in
            guard let googlePlace = googlePlace, error == nil else {
                completion(.failure(PlacesError.failedToGetCoordinates))
                return
            }
            
            let coordinate = CLLocationCoordinate2D(latitude: googlePlace.coordinate.latitude, longitude: googlePlace.coordinate.longitude)
            
            completion(.success(coordinate))
            
        }
        
    }
}
