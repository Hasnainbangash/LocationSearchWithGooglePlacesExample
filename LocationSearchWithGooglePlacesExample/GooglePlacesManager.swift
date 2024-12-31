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
}
