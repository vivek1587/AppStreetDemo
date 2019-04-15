//
//  ViewController.swift
//  FlickrImageDemo
//
//  Created by Vivek  Dubey on 11/04/19.
//  Copyright © 2019 Vivek  Dubey. All rights reserved.
//

import UIKit
import SwiftyJSON
import  SDWebImage


class ViewController: BaseVC {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var loadingFavoriteList = false
    var totalFavoriteListFromServer = 0
    var offset = 0
    let refresher = UIRefreshControl()
    let API_KEY = "bbd76b7e2484c0d671a20ab5df868ce4"
    let URL = "https://api.flickr.com/services/rest/"
    let METHOD = "flickr.photos.search"
    let FORMAT_TYPE:String = "json"
    let JSON_CALLBACK:Int = 1
    let PRIVACY_FILTER:Int = 1
    
 // let  key = bbd76b7e2484c0d671a20ab5df868ce4
 // let   Secret = 422ab9596a22d67d
    
  //  var imageCache = [String:UIImage]()
  //  let imageCache = NSCache<NSString, UIImage>()
    
    var noOfItemInRow = 3
   // var x : Int
    
    var searchParams = [
        "method":"flickr.photos.search",
        "api_key":"bbd76b7e2484c0d671a20ab5df868ce4",
        "privacy_filter":1,
        "tags":"forest",
        "format":"json",
        "nojsoncallback" : 1,
        "page" : 1,
        "extras" : "url_o"
        ] as [String : Any]
    
    var arrayPhoto : [Photo] = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.dataSource = self
        collectionView.delegate = self
       // collectionView.backgroundColor = .black
        self.setUpUIControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.collectionView.reloadData()
        
//        searchImageAPI(params: searchParams)
        
//        if self.arrayCategory.count == 0 {
//            self.getTagsAPI()
//        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        for subView in self.searchBar.subviews  {
            for subsubView in subView.subviews  {
                if let textField = subsubView as? UITextField {
                    textField.layer.cornerRadius = 6
                    textField.layer.masksToBounds = true
                    textField.bounds = CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 36.5)
                    textField.textColor = UIColor.init(red: 158/255, green: 158/255, blue: 158/255, alpha: 1.0)
                    textField.tintColor = UIColor.init(red: 158/255, green: 158/255, blue: 158/255, alpha: 1.0)
                   // textField.font = UIFont.fontGillSansReguler(fontSize: 20)
                    textField.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
                }
            }
        }
    }
    
    func setUpUIControl() {
    
        self.navigationItem.title = NSLocalizedString("Search", comment: "")
        self.setLeftBarButton(imageName: "icon_chip", width: 24.0)
        let leftNavBarButton = UIBarButtonItem(customView:self.searchBar)
        self.navigationItem.rightBarButtonItem = leftNavBarButton
        //Setup UICollectionView
   
        self.searchBar.placeholder = NSLocalizedString("Search Image", comment: "")
        self.searchBar.returnKeyType = .done
        self.searchBar.enablesReturnKeyAutomatically = false
        self.searchBar.delegate = self
        
     
    }
    
    override func actionLeftNavigationItem() {
        
        
        
        let alert = UIAlertController(title: "Title", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "2", style: .default , handler:{ (UIAlertAction)in
            print("User click Approve button")
            self.noOfItemInRow = 2
            self.collectionView.reloadData()
            
        }))
        
        alert.addAction(UIAlertAction(title: "3", style: .default , handler:{ (UIAlertAction)in
            print("User click Edit button")
            self.noOfItemInRow = 3
            self.collectionView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "4", style: .destructive , handler:{ (UIAlertAction)in
            print("User click Delete button")
            self.noOfItemInRow = 4
            self.collectionView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
        
    
    }
    
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "imgDetailIdentifier")
        {
            let detailVC = segue.destination as? ImageDetailViewController
            
            if let urlStr = sender as? String
            {
                detailVC?.imgUrl = urlStr
            }
           
        }
    }


}

extension ViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayPhoto.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CusstomCVCell
       // cell?.backgroundColor = .red
        let photo = arrayPhoto[indexPath.row]
        
        let str1 = "https://farm"
        let str2 = "\(photo.farm ?? 0)"
        let str3 = ".staticflickr.com/"
        let str4 = photo.server
        let str5 = photo.id
        let str6 = photo.secret
        
        let str7 = str1 + str2 + str3 +  str4! + "/" + str5!
        
       // var photoStaticURL = "https://farm" + photo.farm + ".staticflickr.com/" +  photo.server + "/" + photo.id + "_" + photo.secret + "_b.jpg"
        
        let photoStaticURL = str7 + "_" + str6! + "_b.jpg"
        print(photoStaticURL)
        
       // let url = Utilities.encodedUrl(urlString: photoStaticURL)
       // cell?.imgView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder_brand"))
        
        cell?.imgView.backgroundColor = UIColor.brown
        
        cell?.imgView?.image = UIImage(named: "brandLogo")
        
        let fileUrl = NSURL(string: photoStaticURL)
        
        if let image = fileUrl!.cachedImage {
            // Cached: set immediately.
            cell?.imgView?.image = image
            cell?.imgView?.alpha = 1
        } else {
            // Not cached, so load then fade it in.
            cell?.imgView?.alpha = 1
            fileUrl!.fetchImage { image in
                // Check the cell hasn't recycled while loading.
                if cell!.imageUrl == fileUrl{
                    cell?.imgView?.image = image
                    UIView.animate(withDuration: 0.3) {
                        cell?.imgView?.alpha = 1
                    }
                }
            }
        }
        
        
        // If this image is already cached, don't re-download
     
        
//        if let img = imageCache[photoStaticURL] {
//            cell?.imgView?.image = img
//        }
//        else {
//            // The image isn't cached, download the img data
//            // We should perform this in a background thread
//            let request: NSURLRequest = NSURLRequest(url: url!)
//            let mainQueue = OperationQueue.main
//            NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
//                if error == nil {
//                    // Convert the downloaded data in to a UIImage object
//                    let image = UIImage(data: data!)
//                    // Store the image in to our cache
//                    self.imageCache[photoStaticURL] = image
//                    // Update the cell
//
//                    DispatchQueue.main.async(execute: {
//                        if let cellToUpdate = collectionView.cellForItem(at: indexPath) as? CusstomCVCell {
//                            cellToUpdate.imgView?.image = image
//
//                        }
//                    })
//
//                }
//                else {
//                    print("Error: \(error?.localizedDescription)")
//                }
//            })
//        }
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if(noOfItemInRow == 2)
        {
            return CGSize(width: (collectionView.frame.size.width/2)-5, height: (collectionView.frame.size.width/2))
        }else if(noOfItemInRow == 4){
            
            return CGSize(width: (collectionView.frame.size.width/4)-5, height: (collectionView.frame.size.width/4))
        }else{
            return CGSize(width: (collectionView.frame.size.width/3)-5, height: (collectionView.frame.size.width/3))
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       // return UIEdgeInsets(top:5, left:5, bottom:5, right:5)
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
 //   MARK:- UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.arrayPhoto.count - 1 {
            self.callLoadMore()
        }
    }
    
  //  MARK:- Call Load More
    func callLoadMore() {
        if self.loadingFavoriteList == true {
            return
        }
        else {
            if self.totalFavoriteListFromServer > self.arrayPhoto.count {
                loadingFavoriteList = true
                searchParams["page"] = offset
                
                searchImageAPI(params: searchParams)
            }
        }
    }
}

extension ViewController : UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let data = arrayPhoto[indexPath.row]
       // self.performSegue(withIdentifier: "imgDetailIdentifier", sender: data.url_o)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let objRegisterVC = storyboard.instantiateViewController(withIdentifier: "ImageDetailViewController") as? ImageDetailViewController
        
        if let url = data.url_o,url.count>0
        {
        objRegisterVC?.imgUrl = url
       // self.navigationController?.pushViewController(objRegisterVC!, animated: true)
        
        UIView.animate(withDuration: 0.75, animations: { () -> Void in
            UIView.setAnimationCurve(UIView.AnimationCurve.easeIn)
            self.navigationController!.pushViewController(objRegisterVC!, animated: false)
            UIView.setAnimationTransition(UIView.AnimationTransition.flipFromRight, for: self.navigationController!.view!, cache: false)
        })
        }
    }
}

extension ViewController: UISearchBarDelegate {
    
    //MARK: UISearchBar
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
     
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
   
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
      print("searchBarTextDidBeginEditing")
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       print("searchBarSearchButtonClicked")
        
        self.view.endEditing(true)
        searchBar.resignFirstResponder()
        let srchText = searchBar.text?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        if(srchText?.count != 0)
        {
            arrayPhoto.removeAll()
            searchParams["tags"] = srchText
            searchParams["page"] = 1
            self.offset = 0
            searchImageAPI(params: searchParams)
        }
    }
    
    func filterArray(searchText : String) {
//        self.arrayFilteredTags.removeAll()
//        self.arrayFilteredTags = self.arrayTags.filter {
//            $0.name?.range(of: searchText, options: .caseInsensitive) != nil
//        }
//        self.tblViewTags.reloadData()
    }
    

}



extension ViewController {
    func searchImageAPI(params:[String:Any]) {
        debugPrint("Search outFits Parameters")
        Utilities.showLoader()
        APIManager.apiGet(serviceName: URL, parameters: params) { (response:JSON?, error:NSError?) in
            Utilities.hideLoader()
            if error != nil {
                Utilities.alertMessage(title: Constants.appName, message: (error?.localizedDescription)!, buttonText: Constants.ok, viewController: self, completionHandler: {
                })
                return
            }
            guard let _ = response else {
                Utilities.alertMessage(title: Constants.appName, message: "Something went wrong", buttonText: Constants.ok, viewController: self, completionHandler: {
                })
                return
            }
            debugPrint(response!)
            self.handleAPIResponse(response: response!)
        }
    }
    
    func handleAPIResponse(response:JSON?) {
        if let response = response {
            if (response[Constants.ServerKey.error].exists()) {
                if response[Constants.ServerKey.statusCode].intValue == 401 {
                    Utilities.alertMessage(title: Constants.appName, message: (response[Constants.ServerKey.error][Constants.ServerKey.message].stringValue), buttonText: Constants.ok, viewController: self, completionHandler: {
                        //UserManager.shared().logoutUser()
                    })
                    return
                }
                Utilities.alertMessage(title: Constants.appName, message: response[Constants.ServerKey.message].stringValue, buttonText: Constants.ok, viewController: self, completionHandler: {
                })
            }
            if response["stat"] == "ok" {
                if self.offset == 0 {
                    self.arrayPhoto.removeAll()
                }
                
                let photosDict = response["photos"].dictionary
                let dataArray = photosDict!["photo"]?.array
                
                if let total = photosDict!["total"]?.string
                {
                    self.totalFavoriteListFromServer = Int(total)!
                }
                
                self.offset = self.offset + 1
                self.loadingFavoriteList = false

                
                for dataObject in (dataArray)! {
                    
                    let imageData = Photo(photo: dataObject)
                    self.arrayPhoto.append(imageData)
                    
                }
               
           
                self.collectionView.reloadData()
            }
        }
}
    
}

class MyImageCache {
    
    static let sharedCache: NSCache = {() -> NSCache<NSString, UIImage> in
        let cache = NSCache<NSString, UIImage>()
        cache.name = "MyImageCache"
      //  cache.countLimit = 200 // Max 20 images in memory.
      //  cache.totalCostLimit = 100*1024*1024 // Max 10MB used.
        return cache
    }()
    
}

extension NSURL {
    
    typealias ImageCacheCompletion = (UIImage) -> Void
    
    /// Retrieves a pre-cached image, or nil if it isn't cached.
    /// You should call this before calling fetchImage.
    var cachedImage: UIImage? {
        return MyImageCache.sharedCache.object(
            forKey: absoluteString! as NSString)
    }
    
    /// Fetches the image from the network.
    /// Stores it in the cache if successful.
    /// Only calls completion on successful image download.
    /// Completion is called on the main thread.
    func fetchImage(completion: @escaping ImageCacheCompletion) {
        let task = URLSession.shared.dataTask(with: self as URL) {
            data, response, error in
            if error == nil {
                if let  data = data,
                    let image = UIImage(data: data) {
                    MyImageCache.sharedCache.setObject(
                        image,
                        forKey: self.absoluteString! as NSString,
                        cost: data.count)
                    DispatchQueue.main.async(execute: {
                        completion(image)
                    })

                }
            }
        }
        task.resume()
    }
    
}

