//
//  drinks.swift
//  Cocktail
//
//  Created by Ekin Barış Demir on 11.04.2021.
//

import Foundation
import UIKit

class Drinks: NSObject, Codable, NSCoding{
    
    var img: Data?
    var idDrink: String?
    var strDrink: String?
    var strCategory: String?
    var strAlcoholic: String?
    var strInstructions: String?
    var strDrinkThumb: String?
    var strIngredient1: String?
    var strIngredient2: String?
    var strIngredient3: String?
    var strGlass: String?
    
    
    
    init(img: Data, strDrink: String, strCategory: String, strAlcoholic: String, strInstructions:String, strIngredient1:String, strIngredient2: String, strDrinkThumb: String, strIngredient3: String, strGlass: String ) {
        
        self.img = img
        self.strDrink = strDrink
        self.strAlcoholic = strAlcoholic
        self.strCategory = strCategory
        self.strGlass = strGlass
        self.strIngredient1 = strIngredient1
        self.strIngredient2 = strIngredient2
        self.strIngredient3 = strIngredient3
        self.strInstructions = strInstructions
        self.strDrinkThumb = strDrinkThumb
        
        
    }
    
  //  override init() {
  //      super.init() // This got rid of the "Missing argument for parameter 'coder' in call.
  //  }
    
    required convenience init?(coder aCoder: NSCoder) {
        
        guard let img = aCoder.decodeObject(forKey: "img") as? Data ?? nil else { return nil  }
        let strDrink = aCoder.decodeObject(forKey: "strDrink") as! String
        let strCategory = aCoder.decodeObject(forKey: "strCategory") as! String
        let strAlcoholic = aCoder.decodeObject(forKey: "strAlcoholic") as! String
        let strInstructions = aCoder.decodeObject(forKey: "strInstructions") as! String
        let strIngredient1 = aCoder.decodeObject(forKey: "strIngredient1") as! String
        let strIngredient2 = aCoder.decodeObject(forKey: "strIngredient2") as! String
        let strIngredient3 = aCoder.decodeObject(forKey: "strIngredient3") as! String
        let strGlass = aCoder.decodeObject(forKey: "strGlass") as! String
        let strDrinkThumb = aCoder.decodeObject(forKey: "strDrinkThumb") as! String
        
        
        self.init(img: img, strDrink: strDrink, strCategory: strCategory, strAlcoholic: strAlcoholic, strInstructions: strInstructions, strIngredient1: strIngredient1, strIngredient2: strIngredient2, strDrinkThumb: strDrinkThumb, strIngredient3: strIngredient3, strGlass: strGlass)
    }
    
    func encode(with acoder: NSCoder) {
        acoder.encode(img,forKey: "img")
        acoder.encode(strDrink,forKey: "strDrink")
        acoder.encode(strCategory,forKey: "strCategory")
        acoder.encode(strAlcoholic,forKey: "strAlcoholic")
        acoder.encode(strInstructions,forKey: "strInstructions")
        acoder.encode(strIngredient1,forKey: "strIngredient1")
        acoder.encode(strIngredient2,forKey: "strIngredient2")
        acoder.encode(strIngredient3,forKey: "strIngredient3")
        acoder.encode(strGlass,forKey: "strGlass")
        acoder.encode(strDrinkThumb,forKey: "strDrinkThumb")
        
        
        
    }
    
    
}

