//
//  ImageDetailViewController.swift
//  FlickrImageDemo
//
//  Created by Vivek  Dubey on 14/04/19.
//  Copyright © 2019 Vivek  Dubey. All rights reserved.
//

import UIKit

class ImageDetailViewController: BaseVC {
    
    @IBOutlet weak var imgView: UIImageView!
    var imgUrl : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(imgUrl)
        if(imgUrl.count>0)
        {
            let fileUrl = NSURL(string: imgUrl)
            
            Utilities.showLoader()
            
            if let image = fileUrl!.cachedImage {
                // Cached: set immediately.
                imgView.image = image
                imgView.alpha = 1
                Utilities.hideLoader()
            } else {
                
     
                
                // Not cached, so load then fade it in.
                imgView.alpha = 1
                fileUrl!.fetchImage { image in
                    // Check the cell hasn't recycled while loading.
                   // if cell!.imageUrl == fileUrl{
                    self.imgView.image = image
                    Utilities.hideLoader()
                        UIView.animate(withDuration: 0.3) {
                            self.imgView.alpha = 1
                        }
                    //}
                }
            }
        }
    }
    
//
    
    override func actionLeftNavigationItem() {
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
