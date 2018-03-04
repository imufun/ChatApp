//
//  Extension.swift
//  ChatApp
//
//  Created by sinbad on 6/16/1439 AH.
//  Copyright © 1439 AH sinbad. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingWithUrlString(urlString: String) {
        
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = cachedImage
            return
        }
        let url  = URL(string: urlString)!
        
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil    {
                print(error!)
                return
            }
            DispatchQueue.main.sync {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
               self.image = downloadedImage
                
                }
             
             
            }
        }).resume()
    }
}
