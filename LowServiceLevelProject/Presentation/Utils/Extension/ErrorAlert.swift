//
//  ErrorAlert.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/03.
//

import Foundation
import SwiftUI

struct LocalizedAlertError: LocalizedError {
    
    let wrappedError: Error
    
    var errorDescription: String? {
        wrappedError.localizedDescription
    }
    
    init?(error: Error?) {
        guard let error else { return nil }
        self.wrappedError = error
    }
}

struct NetworkAlertError: LocalizedError {
    
    let wrappedError: NetworkError
    
    var title: String? {
        wrappedError.title
    }
    
    var errorDescription: String? {
        wrappedError.description
    }
    
    init?(error: NetworkError?) {
        guard let error else { return nil }
        self.wrappedError = error
    }
}

extension View {
    func errorAlert(error: Binding<Error?>) -> some View {
        let localizedAlertError = LocalizedAlertError(error: error.wrappedValue)
        return alert(Text("오류"),isPresented: .constant(localizedAlertError != nil), presenting: localizedAlertError) { _ in
            Button("확인") {
                error.wrappedValue = nil
            }
        } message: { error in
            Text(error.localizedDescription)
        }

    }
    
    func errorAlert(error: Binding<NetworkError?>) -> some View {
        let localizedAlertError = NetworkAlertError(error: error.wrappedValue)
        return alert(Text(localizedAlertError?.title ?? ""),isPresented: .constant(localizedAlertError != nil), presenting: localizedAlertError) { _ in
            Button("확인") {
                error.wrappedValue = nil
            }
        } message: { error in
            Text(error.errorDescription ?? "")
        }

    }
}
