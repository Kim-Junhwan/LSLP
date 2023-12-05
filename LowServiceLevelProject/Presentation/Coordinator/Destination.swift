//
//  Destination.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/05.
//

import Foundation
import SwiftUI

enum Destination {
    case tabBar
    
    var view: some View {
        switch self {
        case .tabBar:
            TabBar()
        }
    }
}
