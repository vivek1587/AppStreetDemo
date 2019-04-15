//
//  ImageCache.swift
//  FlickrImageDemo
//
//  Created by Vivek  Dubey on 14/04/19.
//  Copyright © 2019 Vivek  Dubey. All rights reserved.
//

import Foundation

import UIKit

class ImageCache {
    private let cache = NSCache<NSString, UIImage>()
    private var observer: NSObjectProtocol!
    
    static let shared = ImageCache()
    
  private  init() {
        NotificationCenter.default.addObserver(forName: Notification.Name("test"), object: nil, queue: .main) { [weak self] notification in
            self?.cache.removeAllObjects()
        }
    
  
    }
    
 
    
    deinit {
        NotificationCenter.default.removeObserver(observer)
    }
    
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
