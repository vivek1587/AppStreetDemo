//
//  BaseVC.swift
//  Mirror
//
//  Created by Shailesh Tyagi on 14/08/17.
//  Copyright © 2017 huulke. All rights reserved.
//

import Foundation
import SVProgressHUD

class BaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.fontGillSansLight(fontSize: 30) as Any, NSForegroundColorAttributeName:UIColor.color(withHexCode: Constants.AppColorHexCode.appThemeColorLight, alpha: 1.0)]
        self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(CGFloat(5), for: .default)
        // Sets Bar's Shadow Image (Color)
        //self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(color: UIColor.white), for: .default)
      //  self.navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: UIColor.color(withHexCode: Constants.AppColorHexCode.appThemeColorLight, alpha: 1.0))
    }
    
    //MARK : Setup Left Bar Button
    func setLeftBarButton(imageName : String, width : CGFloat)  {
        var leftBarBtn : UIButton = UIButton()
        var leftBarButtonItem : UIBarButtonItem = UIBarButtonItem()
        leftBarBtn = UIButton()
        leftBarBtn.setImage(UIImage(named : imageName), for: .normal)
        leftBarBtn.frame = CGRect(x : 0,y : 0,width : width,height : 24.0)
        leftBarBtn.imageView?.contentMode = .scaleAspectFit
        leftBarBtn.addTarget(self, action: #selector(BaseVC.actionLeftNavigationItem), for: .touchUpInside)
        leftBarButtonItem = UIBarButtonItem()
        leftBarButtonItem.customView = leftBarBtn
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    func setRightBarButton(imageName : String, width : CGFloat, title : String)  {
        var rightBarBtn : UIButton = UIButton()
        var rightBarButtonItem : UIBarButtonItem = UIBarButtonItem()
        rightBarBtn = UIButton()
        rightBarBtn.setBackgroundImage(UIImage(named : imageName), for: .normal)
        rightBarBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 7, bottom: 11, right: 1)
       // rightBarBtn.titleLabel?.font = UIFont.fontGillSansReguler(fontSize: 10)
        rightBarBtn.setTitle(title, for: .normal)
       // rightBarBtn.setTitleColor(UIColor.color(withHexCode: Constants.AppColorHexCode.appThemeColor, alpha: 1.0), for: .normal)
        rightBarBtn.frame = CGRect(x : 0,y : 0,width: width,height : 24)
        rightBarBtn.imageView?.contentMode = .scaleAspectFit
        rightBarBtn.addTarget(self, action: #selector(BaseVC.actionRightNavigationItem), for: .touchUpInside)
        rightBarButtonItem = UIBarButtonItem()
        rightBarButtonItem.customView = rightBarBtn
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func actionLeftNavigationItem() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func actionRightNavigationItem() {
    }
    
  
    
    func alertMessage(title:String,message:String,buttonText:String,completionHandler:(()->())?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonText, style: .default) { (action:UIAlertAction) in
            completionHandler?()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func alertMessage(title:String,message:String,leftButtonText:String,rightButtonText:String,completionHandler:((_ isLeftButtonPressed:Bool)->())?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let leftButtonAction = UIAlertAction(title: leftButtonText, style: .default) { (action:UIAlertAction) in
            completionHandler?(true)
        }
        
        let rightButtonAction = UIAlertAction(title: rightButtonText, style: .default) { (action:UIAlertAction) in
            completionHandler?(false)
        }
        
        alert.addAction(leftButtonAction)
        alert.addAction(rightButtonAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func delay(time:TimeInterval,completionHandler: @escaping ()->()) {
        let when = DispatchTime.now() + 0.01
        DispatchQueue.main.asyncAfter(deadline: when) {
            completionHandler()
        }
    }
    
    func showLoader() {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setForegroundColor(UIColor.lightGray)
       // SVProgressHUD.setBackgroundColor(UIColor.color(withHexCode: Constants.AppColorHexCode.appThemeColor, alpha: 1.0))
        SVProgressHUD.show()
    }
    
    func showLoader(text:String) {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setForegroundColor(UIColor.lightGray)
        SVProgressHUD.setBackgroundColor(UIColor.darkGray)
       // SVProgressHUD.setFont(UIFont.fontGillSansReguler(fontSize: 12.0)!)
        SVProgressHUD.show(withStatus: text)
    }
    
    func showLoaderWithInteractionOn() {
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setForegroundColor(UIColor.lightGray)
        SVProgressHUD.setBackgroundColor(UIColor.darkGray)
        SVProgressHUD.show()
    }
    
    func showLoaderWithInteractionOn(text:String) {
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setForegroundColor(UIColor.lightGray)
        SVProgressHUD.setBackgroundColor(UIColor.darkGray)
      //  SVProgressHUD.setFont(UIFont.fontGillSansReguler(fontSize: 12.0)!)
        SVProgressHUD.show(withStatus: text)
    }
    
    func hideLoader() {
        SVProgressHUD.dismiss()
    }
    
    func hideLoader(delay:TimeInterval) {
        SVProgressHUD.dismiss(withDelay: delay)
    }
}
