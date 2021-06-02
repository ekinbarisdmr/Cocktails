//
//  StoreManager.swift
//  Cocktail
//
//  Created by Ekin Barış Demir on 30.05.2021.
//

import Foundation
import UIKit

class StoreManager {
    
    static let shared = StoreManager()
    
    
    private static func storeDrinks(data : [Drinks]) -> NSData {
        
        return NSKeyedArchiver.archivedData(withRootObject: data as NSArray) as NSData
    }
    
    
    
    func loadDrinks() -> [Drinks]? {
        
        if let unarchivedObject = UserDefaults.standard.object(forKey: "userDrinks") as? Data {
            
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? [Drinks]
        }
        
        return nil
    }
    
    
    
    func getDrinks() -> [Drinks] {
        var userDrinks: [Drinks] = [Drinks]()
        if StoreManager.shared.loadDrinks() == nil {
            StoreManager.shared.saveDrinks(data: userDrinks)
        }
        else {
            userDrinks = StoreManager.shared.loadDrinks() ?? []
        }
        return userDrinks
    }
    
    
    
    func saveDrinks(data : [Drinks]?) {
        
        let archivedObject = StoreManager.storeDrinks(data: data!)
        UserDefaults.standard.set(archivedObject, forKey: "userDrinks")
        UserDefaults.standard.synchronize()
    }
    
    
    
}


