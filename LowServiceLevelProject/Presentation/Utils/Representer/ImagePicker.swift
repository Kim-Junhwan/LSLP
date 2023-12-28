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
    
    @Binding var selectImage: [Data]
    @Binding var currentError: Error?
    var imageSize: Float
    let selectionLimit: Int
    
    init(selectImage: Binding<[Data]>, currentError: Binding<Error?>, imageSize: Float, selectionLimit: Int = 1) {
        self._selectImage = selectImage
        self._currentError = currentError
        self.imageSize = imageSize
        self.selectionLimit = selectionLimit
    }
    
    func makeUIViewController(context: Context) -> some PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        config.selectionLimit = selectionLimit
        let picker = PHPickerViewController(configuration: config)
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
                        guard let convertImage = image as? UIImage, let imageData = convertImage.downSamplingImage(maxSize: CGFloat(self.parentView.imageSize)).jpegData(compressionQuality: 1.0) else { return }
                        DispatchQueue.main.async {
                            self.parentView.selectImage.append(imageData) 
                        }
                    }
                }
            }
        }
    }
}
