//
//  UIImage+Resize.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/19/23.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import UIKit
import MathKit

public extension UIImage {

    func crop(x: Int, y: Int, width: Int, height: Int) -> UIImage? {
        if width > 0 && size.width > 0 && height > 0 && size.height > 0 {
            let imageRect = CGRect(x: CGFloat(-x),
                                   y: CGFloat(-y),
                                   width: size.width,
                                   height: size.height)
            
            UIGraphicsBeginImageContextWithOptions(CGSize(width: CGFloat(width), height: CGFloat(height)), true, self.scale)
            let context = UIGraphicsGetCurrentContext()
            
            // Fill the background with black
            context?.setFillColor(UIColor.black.cgColor)
            context?.fill(CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))
            
            // Draw the image within the given rect
            draw(in: imageRect)
            
            let result = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return result
        }
        return nil
        
    }
    
    func resize(_ size: CGSize) -> UIImage? {
        if size.width > 0 && self.size.width > 0 && size.height > 0 && self.size.height > 0 {
            UIGraphicsBeginImageContext(CGSize(width: size.width, height: size.height))
            draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
            let result = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext();
            return result;
        }
        return nil
    }
    
    func resizeAspectFill(_ size: CGSize) -> UIImage? {
        if size.width > 0 && self.size.width > 0 && size.height > 0 && self.size.height > 0 {
            UIGraphicsBeginImageContext(CGSize(width: size.width, height: size.height))
            
            let aspect = size.getAspectFill(self.size)
            
            let rect = CGRect(x: size.width * 0.5 - aspect.size.width * 0.5,
                              y: size.height * 0.5 - aspect.size.height * 0.5,
                              width: aspect.size.width,
                              height: aspect.size.height)
            draw(in: rect)
            let result = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext();
            return result;
        }
        return nil
    }
    
    func resizeAspectFit(_ size: CGSize) -> UIImage? {
        if size.width > 0 && self.size.width > 0 && size.height > 0 && self.size.height > 0 {
            UIGraphicsBeginImageContext(CGSize(width: size.width, height: size.height))
            
            let aspect = size.getAspectFit(self.size)
            
            let rect = CGRect(x: size.width * 0.5 - aspect.size.width * 0.5,
                              y: size.height * 0.5 - aspect.size.height * 0.5,
                              width: aspect.size.width,
                              height: aspect.size.height)
            draw(in: rect)
            let result = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext();
            return result;
        }
        return nil
    }
}
