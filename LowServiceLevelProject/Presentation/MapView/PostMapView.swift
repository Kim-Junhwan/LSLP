//
//  PostMapView.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/18.
//

import SwiftUI
import MapKit

struct PostMapView: View {
    
    
    var body: some View {
        if #available(iOS 17.0, *) {
            ZStack {
                Map {
                    
                }
                
            }
        } else {
        }
    }
}

extension CLLocationCoordinate2D {
    static let weequahicPark = CLLocationCoordinate2D(latitude: 40.7063, longitude: -74.1973)
    static let empireStateBuilding = CLLocationCoordinate2D(latitude: 40.7484, longitude: -73.9857)
    static let columbiaUniversity = CLLocationCoordinate2D(latitude: 40.8075, longitude: -73.9626)
}

#Preview {
    PostMapView()
}
