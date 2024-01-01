//
//  SelectImageView.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/30.
//

import SwiftUI

struct SelectImageView: View {
    
    @Binding var imageData: Data
    var imageIndex: Int
    var action: (Int) -> ()
    
    var imageView: some View {
        if let image = UIImage(data: imageData) {
            Image(uiImage: image)
                .resizable()
        } else {
            Image(systemName: "xmark")
        }
    }
    
    var body: some View {
        ZStack {
            imageView
                .scaledToFill()
                .overlay {
                    Button (action: {
                        action(imageIndex)
                    }, label: {
                        Image(systemName: "xmark")
                    })
                }
            
        }
    }
}

//#Preview {
//    SelectImageView(imageData: .constant(Data()))
//}
