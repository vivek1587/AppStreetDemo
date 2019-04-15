//
//  Constants.swift
//  Mirror
//
//  Created by Shailesh Tyagi on 03/08/17.
//  Copyright © 2017 huulke. All rights reserved.
//

import Foundation
import UIKit

let kAppDelegate = UIApplication.shared.delegate as! AppDelegate
let kUserDefaults = UserDefaults.standard

struct Constants {
    
    static let BASE_URL = Constants.apiBaseURL()
    static let appName = "Mirror"
    static let ok = "Ok"
    
    static func apiBaseURL() -> String {
        return ConfigurationManager.sharedManager.APIEndpoint()
    }
    
    //MARK:- Image Name
    struct ImageName {
        static let acceptPolicy  = "icon_checked"
        static let refusePolicy  = "icon_unchecked"
        static let navigationBack  = "icon_back"
        static let profileAvtar = "foto_profilo"
        static let favoritePlaceholder = "img_placeholder"
        static let logoMirror = "logo_Mirror"
        static let logoHome = "logo_Home"
        static let iconMenu = "icon_Menu"
        static let placeholderBrand = "placeholder_brand"
    }
    
    //MARK:- Button Title
    struct ButtonTitle {
    }
    
    //MARK:- Button Title
    struct AppColorHexCode {
        static let appThemeColor  = "cbb398" // "B58B5D"
        static let appThemeColorLight  = "cbb398" //"C59C71"
        static let appBlackColor  = "25211e"
        static let appGrayColor  = "666666"
        static let appGrayColorLight  = "BEC3C6"
    }
    
    //MARk:- Urls
    struct Urls {
        static let newsPaper  = "http://www.vogue.it/moda/tendenze/"
    }
    
    //MARK:- StoryBoards
    struct StoryBoard {
        static let MainStoryboard  = "Main"
        static let WalkThroughStoryboard  = "Walkthrough"
        static let TabBarStoryboard  = "TabBar"
        
        struct Identifer {
            static let WalkthroughNAV       = "WalkthroughNAV"
            static let TabBarVC             = "TabBarVC"
            static let LoginNAV             = "LoginNAV"
            static let LoginVC              = "LoginVC"
            static let RegistrationVC       = "RegistrationVC"
            static let HomeVC               = "HomeVC"
            static let ViewProfileVC        = "ViewProfileVC"
            static let EditProfileVC        = "EditProfileVC"
            static let ProfileNAV           = "ProfileNAV"
            static let FavoriteClothesVC    = "FavoriteClothesVC"
            static let SideMenuVC           = "SideMenuVC"
            static let ChangePasswordVC     = "ChangePasswordVC"
            static let ChangePasswordNAV    = "ChangePasswordNAV"
            static let OutfitDetailVC       = "OutfitDetailVC"
            static let TutorialVC           = "TutorialVC"
            static let AccountDetailVC      = "AccountDetailVC"
            static let SearchOutfitVC       = "SearchOutfitVC"
            static let OrderSummaryVC       = "OrderSummaryVC"
            static let AddShippingAddressVC = "AddShippingAddressVC"
            static let PaymentMethodVC      = "PaymentMethodVC"
            static let ConfirmOrderVC       = "ConfirmOrderVC"
            static let MyOrdersVC           = "MyOrdersVC"
            static let MyOrdersNAV          = "MyOrdersNAV"
            static let ForgotPasswordVC     = "ForgotPasswordVC"
            static let ResetPasswordNAV     = "ResetPasswordNAV"
            static let ResetPasswordVC      = "ResetPasswordVC"
            static let CommentVC            = "CommentVC"
            static let FavouriteListVC      = "FavouriteListVC"
            static let FavouriteListNAV     = "FavouriteListNAV"
            static let MirrorWebsiteVC     = "MirrorWebsiteVC"
        }
    }
    
    //MARK:- API Urls
    struct API {
    
        //APIs
        static let registration = Constants.API.apiURL("user")
        static let login = Constants.API.apiURL("login")
        static let uplaodPicture = Constants.API.apiURL("user/picture")
        static let loginWithFB = Constants.API.apiURL("social/auth")
        static let favoriteList = Constants.API.apiURL("favourites")
        static let addFavoriteTags = Constants.API.apiURL("user/tags/add")
        static let outfits = Constants.API.apiURL("user/outfits")
        static let favoriteOutFitList = Constants.API.apiURL("user/favourite/outfits")
        static let outfitDetail = Constants.API.apiURL("user/outfit")
        static let logout = Constants.API.apiURL("user/logout")
        static let changePassword = Constants.API.apiURL("user/password/change")
        static let forgotPassword = Constants.API.apiURL("user/forgot/password")
        static let resetPassword = Constants.API.apiURL("user/reset/password")
        static let provider = Constants.API.apiURL("account")
        static let CartAPI = Constants.API.apiURL("user/cart/item")
        static let searchOutfits = Constants.API.apiURL("outfits/by/filter")
        static let tags = Constants.API.apiURL("tags")
        static let orderSummary = Constants.API.apiURL("user/order/summary")
        static let shippingAddress = Constants.API.apiURL("user/address")
        static let transactionCheckout = Constants.API.apiURL("payment/checkout")
        static let transactionUpdate = Constants.API.apiURL("payment/update")
        static let myOrders = Constants.API.apiURL("user/orders")
        static let brandCategory = Constants.API.apiURL("brand/category")
        static let setFavourite = Constants.API.apiURL("user/favourites")
        static let setLike = Constants.API.apiURL("user/outfit/like")
        static let comments = Constants.API.apiURL("user/outfit")
        static let webImages = Constants.API.apiURL("web/images")
        static let mercuryCardList = Constants.API.apiURL("cards")
        static let addNewCardDetail = Constants.API.apiURL("payment/mercury")
        static let currencyList = Constants.API.apiURL("currency")
        static func apiURL(_ methodName: String) -> String {
            return BASE_URL + methodName
        }
        
        struct AccountPutAction {
            static let follow = "follow"
        }
    }
    
    //MARK:- User Default Keys
    struct UserDefaultsKey {
        static let isLoggedIn = "isLoggedIn"
        static let isTutorialDone = "kIsTutorialDone"
        static let isLoggedOut = "kIsLoggedOut"
        static let isProfileCompleted = "kIsProfileCompleted"
        static let accessToken = "kDeviceToken"
        static let profileImageURL = "kProfileImageURL"
        static let CartItemCount = "kCartItemCount"
    }
    
    //MARK:- Data Limits For API Call
    struct dataLimits {
        static let recordLimit =  "10"
    }
    
    //MARK:- Animation Durations
    struct AnimationDuration {
        static let sideMenuAnimationDuration = 0.25
    }
    
    var animationDuration = 0.3
    
    //MARK:- Server Keys
    struct ServerKey {
        
        // Parameter Like OutFit
        static let outfitId = "outfitId"
        
        // Parameter Brand category
        static let category = "category"
        static let brands = "brands"
        
        // Parameter Keys for Payment
        static let transactionToken = "transactionToken"
        static let transactionId = "transactionId"
        static let payerId = "payerId"
        static let status = "status"
        
        //PaymentCheckOut Parameter
        static let addressId = "addressId"
        
        //Add Shipping Address Parameter
        static let houseNo = "houseNo"
        static let street = "street"
        static let state = "state"
        static let city = "city"
        static let country = "country"
        static let zip = "zip"
        static let mobilePrefix = "mobilePrefix"
        static let mobile = "mobile"
        
        //Search outFit Parameter
        static let brand = "brand"
        static let minPrice = "minPrice"
        static let maxPrice = "maxPrice"
        
        //Brand Detail Response Keys
        static let outfits = "outfits"
        
        //OutfitDetail parameter
        static let direction = "direction"
        static let click = "click"
        static let id = "id"
        static let size = "size"
        
        //OutfitDetail Response Keys
        static let outfit = "outfit"
        static let items = "items"
        
        //Add Favourite parameter
        static let tags = "tags"
        
        // Pagination Keys - Comman
        static let offset = "offset"
        static let limit = "limit"
        
        //Server Authentication Token Parameter Key
        static let Authorization = "Authorization"
        
        //Server Authentication Token Response Key
        static let token = "token"
        
        //ChangePassword Parameter Keys
        static let UserId = "userId"
        static let OldPassword = "oldPassword"
        static let NewPassword = "newPassword"
        static let ConfirmPassword = "confirmPassword"
        
        // Add New Card parameter keys
        static let cardHolderName = "cardHolderName"
        static let cardNumber = "cardNumber"
        static let expiryMonth = "expiryMonth"
        static let expiryYear = "expiryYear"
        static let cvv = "cvv"
        static let saveCard = "saveCard"
      
        
        // Response Keys
        static let statusCode = "statusCode"
        static let meta = "meta"
        static let data = "data"
        static let url = "url"
        static let error = "error"
        static let message = "message"
        static let totalRecords = "totalCount"
        
        struct UserInfo {
            static let id = "id"
            static let userName  = "userName"
            static let name = "name"
            static let email = "email"
            static let password = "password"
            static let firstName = "firstName"
            static let lastName = "lastName"
            static let userType = "userType"
            static let signupMode = "signupMode"
            static let fbId = "fbId"
            static let mobile = "mobile"
            static let gender = "gender"
            static let dob = "dob"
            static let lat = "lat"
            static let lng = "lng"
            static let tags = "tags"
            static let picture = "picture"
            static let watchOutfit = "watchOutfit"
            static let itemsInCart = "itemsInCart"
            static let deviceToken = "deviceToken"
            static let createdAt = "created_at"
            static let updatedAt = "updated_at"
            static let currency  = "currency"
        }
    }
}
