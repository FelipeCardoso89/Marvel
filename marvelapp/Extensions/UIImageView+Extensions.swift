//
//  UIImageView+Extensions.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 06/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImage(from url: URL, completion: ((Error?)-> Void)? = nil) {
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async {
                self.image = cachedImage
                completion?(nil)
            }
            return
        }
        
        self.image = nil
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion?(error)
                return
            }
            
            guard let data = data else {
                completion?(NSError(domain: "", code: 000, userInfo: nil))
                return
            }
            
            
            DispatchQueue.main.async {
                
                guard let downloadedIamge = UIImage(data: data) else {
                    completion?(NSError(domain: "", code: 000, userInfo: nil))
                    return
                }
                
                imageCache.setObject(downloadedIamge, forKey: url.absoluteString as NSString)
                
                self.image = downloadedIamge
                completion?(nil)
            }
            
        }.resume()
    }
    
}
