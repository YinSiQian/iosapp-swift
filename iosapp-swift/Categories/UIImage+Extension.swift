//
//  UIImage+Extension.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/24.
//  Copyright © 2017年 ysq. All rights reserved.
//

import Foundation
import QuartzCore

extension UIImage {
    func clip(in rect: CGRect) -> UIImage {
//        let contextImage: UIImage = UIImage(cgImage: self.cgImage!)
//        
//        let contextSize: CGSize = contextImage.size
//        
//        var posX: CGFloat = 0.0
//        var posY: CGFloat = 0.0
//        var cgwidth: CGFloat = CGFloat(rect.width)
//        var cgheight: CGFloat = CGFloat(rect.height)
//        
//        // See what size is longer and create the center off of that
//        if contextSize.width > contextSize.height {
//            posX = ((contextSize.width - contextSize.height) / 2)
//            posY = 0
//            cgwidth = contextSize.height
//            cgheight = contextSize.height
//        } else {
//            posX = 0
//            posY = ((contextSize.height - contextSize.width) / 2)
//            cgwidth = contextSize.width
//            cgheight = contextSize.width
//        }
//        
//        let rect1: CGRect = CGRect.init(x: posX, y: posY, width: cgwidth, height: cgheight)
//        
//        // Create bitmap image from context using the rect
//        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect1)!
//        
//        // Create a new image based on the imageRef and rotate back to the original orientation
//        let image: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
//        
        var clipRect = rect
        
        
        clipRect.origin.x += 20
        clipRect.origin.y += 30
        let imageRef1 = self.cgImage?.cropping(to: clipRect)
        
        UIGraphicsBeginImageContextWithOptions(clipRect.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: clipRect.height)
        context?.scaleBy(x: 1, y: -1)
        context?.draw(imageRef1!, in: clipRect)
        let clipImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        
        return clipImage!
    
        
        
//        let imageRef = self.cgImage!.cropping(to: rect)
//        let cropImage = UIImage(cgImage: imageRef!)
//        return cropImage
    }
}
