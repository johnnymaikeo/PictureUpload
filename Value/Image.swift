//
//  Image.swift
//  Value
//
//  Created by Johnny on 6/2/16.
//  Copyright © 2016 ExxonMobil. All rights reserved.
//

import Foundation

import UIKit

class ImageHelper: NSObject {
    
    
    // Save and load Image
    
    internal func getDocumentsURL() -> NSURL {
        
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        
        return documentsURL
        
    }
    
    internal func fileInDocumentsDirectory(filename: String) -> String {
        
        let fileURL = getDocumentsURL().URLByAppendingPathComponent(filename)
        
        return fileURL.path!
        
    }
    
    func saveImage (image: UIImage, path: String ) -> Bool{
        
        let pngImageData = UIImagePNGRepresentation(image)
        
        let result = pngImageData!.writeToFile(path, atomically: true)
        
        return result
        
    }
    
    func loadImageFromPath(path: String) -> UIImage? {
        
        let image = UIImage(contentsOfFile: path)
        
        if image == nil {
            
            print("missing image at: \(path)")
        }
        
        return image
        
    }
    
    func imagePath (reminder: Int) -> String {
        
        // Define the specific path, image name
        
        let myImageName = "img" + String(reminder) +  ".png"
        let imagePath = self.fileInDocumentsDirectory(myImageName)
        
        return imagePath
        
    }
    
}