//
//  SearchImage.swift
//  FlickrImageDemo
//
//  Created by Vivek  Dubey on 13/04/19.
//  Copyright © 2019 Vivek  Dubey. All rights reserved.
//

import Foundation

import UIKit


import SwiftyJSON

class Photo: NSObject {
    
    var title:String!
    var server:String?
    var owner:String?
    var farm:Int?
    var isfriend:Bool?
    var ispublic:Bool?
   
    var id:String?
    var isFollowed:Int?
    var isfamily:Bool?
    var secret:String?
    var updatedAt:String?
    var url_o : String?
    
    override init() {
    }
    
    init(photo:JSON) {
        
        self.title = photo["title"].stringValue
        self.server = photo["server"].stringValue
        self.owner = photo["owner"].stringValue
        self.farm = photo["farm"].intValue
        self.isfriend = photo["isfriend"].boolValue
        self.ispublic = photo["ispublic"].boolValue
        self.id = photo["id"].stringValue
        self.isFollowed = photo["isFollowed"].intValue
        self.isfamily = photo["isfamily"].boolValue
        self.secret = photo["secret"].stringValue
        self.url_o = photo["url_o"].stringValue
     
    }
}

//struct Photo {
//    var id: String
//    var title: String
//    var farm: String
//    var secret: String
//    var server: String
//    var imageURL: NSURL {
//        get {
//            let url = NSURL(string: "http://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg")!
//            return url
//        }
//    }
//}
