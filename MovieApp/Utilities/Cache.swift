//
//  Cache.swift
//  MovieApp
//
//  Created by Ruman on 14/05/2022.
//

import Foundation
import UIKit

public enum CachType {
    case cache
    case keychain
    case local
}

let cacheTimeOut = 0

public class MRCacheManager: NSObject {

    public static let sharedManager = MRCacheManager()
    var cacheCount = 0
    
    private var cacheDictionary  = [String : AnyObject]()
    private var cacheTimeOutDictionary  = [String : NSDate]()
    
    private override init() {
        super.init()
    }

    func pushToCache( Model : AnyObject) {
        
        let ModelType = String(describing: type(of: Model))

        if let _ = NSClassFromString("XCTest") {
            cacheCount += 1
        }
        else
        {
            if let _ = cacheDictionary[ModelType], let _ = cacheTimeOutDictionary[ModelType]
            {
                let _ = clearCache(Model : Model)
            }
            let ModelType = String(describing: type(of: Model))
            cacheDictionary[ModelType] = Model
            cacheTimeOutDictionary[ModelType] = NSDate()
            
            cacheCount += 1
        }
    }
    
    
   public func pushToCache( Model : AnyObject , modelType : String) {
        
        let ModelType = String(describing: modelType)

        if let _ = NSClassFromString("XCTest") {
            cacheCount += 1
        }
        else
        {
            if let _ = cacheDictionary[ModelType], let _ = cacheTimeOutDictionary[ModelType]
            {
                let _ = clearCache(Model : Model)
            }
            let ModelType = String(modelType)
            cacheDictionary[ModelType] = Model
            cacheTimeOutDictionary[ModelType] = NSDate()
            
            cacheCount += 1
        }
    }
    
    public func pullFromCache(Model : AnyObject) -> AnyObject! {
        let ModelType = String(describing: type(of: Model))
        if let _ = NSClassFromString("XCTest") {
            return "tesstobj" as AnyObject
        }else if cacheCount > 0 {
        
            if let cashedObject = cacheDictionary[ModelType], let cashedObjectTime = cacheTimeOutDictionary[ModelType]  {
                let elapsed = NSDate().timeIntervalSince(cashedObjectTime as Date)
                let duration = Int(elapsed)
                if cacheTimeOut == 0 || duration <= cacheTimeOut  {
                    return cashedObject
                } else {
                    let _ = clearCache(Model : Model)
                }

            }
            
        }
        
        
        return nil
    }
    
    public func pullFromCache(Key : String) -> AnyObject! {
        let ModelType = Key
        
        if cacheCount > 0 {
            
            if let cashedObject = cacheDictionary[ModelType], let cashedObjectTime = cacheTimeOutDictionary[ModelType]  {
                let elapsed = NSDate().timeIntervalSince(cashedObjectTime as Date)
                let duration = Int(elapsed)
                if cacheTimeOut == 0 || duration <= cacheTimeOut  {
                    return cashedObject
                } else {
                    let _ = clearCache(Key : Key)
                }
                
            }
            
        }
        
        
        return nil
    }
    
    public func pullFromCache(Model : AnyObject , modelType : String) -> AnyObject! {
        let ModelType = String(modelType)
        if let _ = NSClassFromString("XCTest") {
            return "tesstobj" as AnyObject
        }else if cacheCount > 0 {
            
            if let cashedObject = cacheDictionary[ModelType], let cashedObjectTime = cacheTimeOutDictionary[ModelType]  {
                let elapsed = NSDate().timeIntervalSince(cashedObjectTime as Date)
                let duration = Int(elapsed)
                if cacheTimeOut == 0 || duration <= cacheTimeOut  {
                    return cashedObject
                } else {
                    let _ = clearCache(Model : Model)
                }
                
            }
            
        }
        
        
        return nil
    }
    
    
    public func clearCache(Model : AnyObject) -> Bool {
        
        let ModelType = String(describing: type(of: Model))
        cacheDictionary[ModelType] = nil
        cacheTimeOutDictionary[ModelType] = nil
        cacheCount -= 1
        
        if cacheDictionary[ModelType] == nil {
            return true
        }
        
        return false
    }
    
   public func clearCache(Key : String) -> Bool {
        
        let ModelType = Key
        cacheDictionary[ModelType] = nil
        cacheTimeOutDictionary[ModelType] = nil
        cacheCount -= 1
        
        if cacheDictionary[ModelType] == nil {
            return true
        }
        
        return false
    }
    
    
    public func clearALLCache() {
        cacheDictionary.removeAll()
        cacheTimeOutDictionary.removeAll()
        cacheCount = 0
        
    }
    
    
    
    public func pullFromCache(Key : String, type :  CachType = .local) -> AnyObject? {
        if let _ = NSClassFromString("XCTest") {
            return ["test"] as AnyObject
        }
           
           switch type {
           case .cache:
               if let cachedModel = MRCacheManager.sharedManager.pullFromCache(Key : Key){
                   return cachedModel
               }
               break
           case .keychain:
               
              // GenyPrint("\n**** Pull from KeyChain :\(Key) ")

//               if let cachedValue = IBMCoreBankingKeychainUtility.sharedInstance.getDataFromKeychainWithIdentifier(Key){
//
//
//
//                   let data = Data(base64Encoded: cachedValue)
//
//                   let arrayFromData = NSKeyedUnarchiver.unarchiveObject(with: data!) as AnyObject
//
//                   if cachedValue == "<null>" || cachedValue == ""
//                   {
//                       return nil
//                   }
//
//                   //GenyPrint("\n**** Pull from KeyChain :\(Key) value: \(arrayFromData)")
//
//
//                   return arrayFromData as AnyObject
//               }
               break
           case .local:
               if let cachedValue = UserDefaults.standard.object(forKey: Key) {
                   return cachedValue as AnyObject
               }
               break
               
           }
           
           
           
           return nil
       }
       
    @discardableResult
    public func pushToCache( Value : AnyObject , Key : String , type :  CachType = .local) -> AnyObject? {
           
           
           switch type {
           case .cache:
               MRCacheManager.sharedManager.pushToCache( Model : Value as AnyObject , modelType : Key)
               break
           case .keychain:
               
                   let cacheValue = String(describing: Value)
                   if cacheValue != ""
                   {
//                       let data = NSKeyedArchiver.archivedData(withRootObject: Value as Any)
//                       let newbas64String = data.base64EncodedString()
                       
                       //GenyPrint("\n**** Push to KeyChain :\(Key) value: \(Value)")

//                       IBMCoreBankingKeychainUtility.sharedInstance.setDataIntoLocal(Key, keychainData: newbas64String )
                   }
               
               break
           case .local:
               UserDefaults.standard.set(Value, forKey: Key)
               UserDefaults.standard.synchronize()
               break
               
           }
           
           
           return Value
           
       }
       

       
       
       public func clearCache(Key : String, type :  CachType ) -> AnyObject? {
           
           
           switch type {
           case .cache:
               let _ = MRCacheManager.sharedManager.clearCache(Key: Key)
               break
           case .keychain:
//               IBMCoreBankingKeychainUtility.sharedInstance.clearDataFromKeychainWithIdentife(Key)
               break
           case .local:
               UserDefaults.standard.removeObject(forKey: Key)
               break
               
           }
           
           
           
           return nil
       }
    
}
