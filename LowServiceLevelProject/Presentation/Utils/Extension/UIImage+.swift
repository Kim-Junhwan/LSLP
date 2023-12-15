//
//  UIImage+.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/15.
//

import Foundation
import UIKit

extension UIImage {
    func downSamplingImage(maxSize:CGFloat) -> UIImage {
        let sourceOptions = [kCGImageSourceShouldCache:false] as CFDictionary
        guard let data = self.pngData() else { return self }
        guard let source = CGImageSourceCreateWithData(data as CFData, sourceOptions) else { return self }
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways:true,
            kCGImageSourceThumbnailMaxPixelSize: maxSize * UIScreen.main.scale ,
            kCGImageSourceShouldCacheImmediately:true,
            kCGImageSourceCreateThumbnailWithTransform:true
        ] as CFDictionary
        guard let downsampledCGImage = CGImageSourceCreateThumbnailAtIndex(source, 0, downsampleOptions) else {
            return self
        }
        guard let downSampleImage = UIImage(cgImage: downsampledCGImage, scale: 1.0, orientation: imageOrientation).cgImage else { return self }
        let rotateImage = UIImage(cgImage: downSampleImage, scale: 1.0, orientation: imageOrientation)
        return rotateImage
    }
}
