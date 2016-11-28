//
//  Extensions.swift
//  chatapp
//
//  Created by Karthik on 11/16/16.
//  Copyright © 2016 shivaprasad. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
       func loadImageUsingCacheWithUrlString(urlString: String) {
        self.image = nil
        
        // check cache for image first
        if let cachedImage = imageCache.object(forKey: (urlString as AnyObject)) as?
            UIImage {
            self.image = cachedImage
            return
        }
        
        
        
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: url! as URL,
                                   completionHandler: { (data, response, error) in
                                    
                                    if error != nil {
                                        print(error)
                                        return
                                    }
                                    DispatchQueue.main.async(execute: {
                                        
                                        if let downloadImage = UIImage(data: data!) {
                                            imageCache.setObject(downloadImage, forKey: urlString as AnyObject)
                                        self.image = UIImage(data: data!)
                                        }
                                        })
        }) .resume()
}
}

