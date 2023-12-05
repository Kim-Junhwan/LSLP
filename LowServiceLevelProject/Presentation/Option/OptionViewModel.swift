//
//  OptionViewModel.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/04.
//

import Foundation
import SwiftUI

final class OptionViewModel: ObservableObject {
    
    @State var successLogout: Bool = false
    
    func logout() {
        do {
            try KeychainService.shared.delete(key: KeychainAuthorizNameSpace.accesshToken)
            try KeychainService.shared.delete(key: KeychainAuthorizNameSpace.refreshToken)
        } catch {
            
        }
        
    }
    
}
