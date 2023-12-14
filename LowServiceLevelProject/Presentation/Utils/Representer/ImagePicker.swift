//
//  ImagePicker.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/14.
//

import Foundation
import SwiftUI
import UIKit
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var selectImage: Data?
    @Binding var currentError: Error?
    
    func makeUIViewController(context: Context) -> some PHPickerViewController {
        let picker = PHPickerViewController(configuration: .init(photoLibrary: .shared()))
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
        let parentView: ImagePicker
        
        init(_ parentView: ImagePicker) {
            self.parentView = parentView
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            guard let selectImageProvider = results.first?.itemProvider else { return }
            if selectImageProvider.canLoadObject(ofClass: UIImage.self) {
                selectImageProvider.loadObject(ofClass: UIImage.self) { image, error in
                    if let error {
                        self.parentView.currentError = error
                    } else {
                        guard let convertImage = image as? UIImage else { return }
                        DispatchQueue.main.async {
                            self.parentView.selectImage = convertImage.jpegData(compressionQuality: 1.0)
                        }
                    }
                }
            }
        }
    }
}
