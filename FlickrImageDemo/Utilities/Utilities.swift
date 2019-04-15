//
//  Utilities.swift
//  Mirror
//
//  Created by Shailesh Tyagi on 03/08/17.
//  Copyright © 2017 huulke. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
import AVFoundation
import SVProgressHUD

class Utilities: NSObject {
        
    enum UIUserInterfaceIdiom : Int{
        case Unspecified
        case Phone
        case Pad
    }
    
    struct ScreenSize{
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct DeviceType{
        static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPHONE_7          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_7P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    }
    static func rect(forSize size: CGSize) -> CGRect {
        return CGRect(origin: .zero, size: size)
    }
    
    static func aspectFitRect(forSize size: CGSize, insideRect: CGRect) -> CGRect {
        return AVMakeRect(aspectRatio: size, insideRect: insideRect)
    }
    
    static func aspectFillRect(forSize size: CGSize, insideRect: CGRect) -> CGRect {
        let imageRatio = size.width / size.height
        let insideRectRatio = insideRect.width / insideRect.height
        if imageRatio > insideRectRatio {
            return CGRect(x: 0, y: 0, width: floor(insideRect.height * imageRatio), height: insideRect.height)
        } else {
            return CGRect(x: 0, y: 0, width: insideRect.width, height: floor(insideRect.width / imageRatio))
        }
    }
    
    static func center(forSize size: CGSize) -> CGPoint {
        return CGPoint(x: size.width / 2, y: size.height / 2)
    }
    
    static func centerTop(forSize size: CGSize, insideSize: CGSize) -> CGPoint {
        return CGPoint(x: insideSize.width / 2, y: size.height / 2)
    }
    
    static func centerBottom(forSize size: CGSize, insideSize: CGSize) -> CGPoint {
        return CGPoint(x: insideSize.width / 2, y: insideSize.height - size.height / 2)
    }
    
    static func centerLeft(forSize size: CGSize, insideSize: CGSize) -> CGPoint {
        return CGPoint(x: size.width / 2, y: insideSize.height / 2)
    }
    
    static func centerRight(forSize size: CGSize, insideSize: CGSize) -> CGPoint {
        return CGPoint(x: insideSize.width - size.width / 2, y: insideSize.height / 2)
    }
    
    static func topLeft(forSize size: CGSize, insideSize: CGSize) -> CGPoint {
        return CGPoint(x: size.width / 2, y: size.height / 2)
    }
    
    static func topRight(forSize size: CGSize, insideSize: CGSize) -> CGPoint {
        return CGPoint(x: insideSize.width - size.width / 2, y: size.height / 2)
    }
    
    static func bottomLeft(forSize size: CGSize, insideSize: CGSize) -> CGPoint {
        return CGPoint(x: size.width / 2, y: insideSize.height - size.height / 2)
    }
    
    static func bottomRight(forSize size: CGSize, insideSize: CGSize) -> CGPoint {
        return CGPoint(x: insideSize.width - size.width / 2, y: insideSize.height - size.height / 2)
    }

    
    struct Version{
        static let SYS_VERSION_FLOAT = (UIDevice.current.systemVersion as NSString).floatValue
        static let iOS7 = (Version.SYS_VERSION_FLOAT < 8.0 && Version.SYS_VERSION_FLOAT >= 7.0)
        static let iOS8 = (Version.SYS_VERSION_FLOAT >= 8.0 && Version.SYS_VERSION_FLOAT < 9.0)
        static let iOS9 = (Version.SYS_VERSION_FLOAT >= 9.0 && Version.SYS_VERSION_FLOAT < 10.0)
        static let iOS10 = (Version.SYS_VERSION_FLOAT >= 10.0 && Version.SYS_VERSION_FLOAT < 11.0)
    }
    
    class func notPrettyString(from object: Any) -> String? {
        if let objectData = try? JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions(rawValue: 0)) {
            let objectString = String(data: objectData, encoding: .utf8)
            return objectString
        }
        return ""
    }
    
    class func encodedUrl(urlString : String) -> URL? {
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded)
        {
            return url
        }
        return nil
    }
    
    class func alertMessage(title:String,message:String,buttonText:String,viewController:UIViewController,completionHandler:(()->())?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonText, style: .default) { (action:UIAlertAction) in
            completionHandler?()
        }
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
        
    }
    
  class  func showLoader() {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setForegroundColor(UIColor.lightGray)
      //  SVProgressHUD.setBackgroundColor(UIColor.color(withHexCode: Constants.AppColorHexCode.appThemeColor, alpha: 1.0))
        SVProgressHUD.show()
    }
    
   class func showLoader(text:String) {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setForegroundColor(UIColor.lightGray)
        SVProgressHUD.setBackgroundColor(UIColor.darkGray)
      //  SVProgressHUD.setFont(UIFont.fontGillSansReguler(fontSize: 12.0)!)
        SVProgressHUD.show(withStatus: text)
    }
    
  class  func showLoaderWithInteractionOn() {
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setForegroundColor(UIColor.lightGray)
        SVProgressHUD.setBackgroundColor(UIColor.darkGray)
        SVProgressHUD.show()
    }
    
  static  func showLoaderWithInteractionOn(text:String) {
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setForegroundColor(UIColor.lightGray)
        SVProgressHUD.setBackgroundColor(UIColor.darkGray)
       // SVProgressHUD.setFont(UIFont.fontGillSansReguler(fontSize: 12.0)!)
        SVProgressHUD.show(withStatus: text)
    }
    
   static func hideLoader() {
        SVProgressHUD.dismiss()
    }
    
  static  func hideLoader(delay:TimeInterval) {
        SVProgressHUD.dismiss(withDelay: delay)
    }
}
