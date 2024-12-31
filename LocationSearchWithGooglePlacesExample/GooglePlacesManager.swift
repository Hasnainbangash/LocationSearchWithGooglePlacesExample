//
//  GooglePlacesManager.swift
//  LocationSearchWithGooglePlacesExample
//
//  Created by Elexoft on 31/12/2024.
//

import Foundation
import GooglePlaces

final class GooglePlacesManager {
    static let shared = GooglePlacesManager()
    
    private let client = GMSPlacesClient.shared()
    
    private init() {}
    
    public func setup() {
        GMSPlacesClient.provideAPIKey("AIzaSyD6-djNbx6qEiPJm0uzYx-pzBbrqItkJnU")
    }
}
