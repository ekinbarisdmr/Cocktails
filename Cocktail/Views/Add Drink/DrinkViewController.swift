//
//  DrinkViewController.swift
//  Cocktail
//
//  Created by Ekin Barış Demir on 18.04.2021.
//

import UIKit

class DrinkViewController: UIViewController,UINavigationControllerDelegate {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var categoryText: UITextField!
    @IBOutlet weak var alcoholicText: UITextField!
    @IBOutlet weak var ingredient1Text: UITextField!
    @IBOutlet weak var ingredient2Text: UITextField!
    @IBOutlet weak var ingredient3Text: UITextField!
    @IBOutlet weak var glassText: UITextField!
    @IBOutlet weak var instructionsText: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var userImg: UIImageView!
    
    
    var selectedImg: UIImage?
    var imagePicker = UIImagePickerController()
    var userDrinks: [Drinks] = []
    var imageUrl: URL?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDrinks = StoreManager.shared.getDrinks()
        
        
        addButton.backgroundColor = UIColor.customColor()
        addButton.tintColor = .white
        addButton.layer.cornerRadius = addButton.frame.height / 2
        userImg.layer.cornerRadius = userImg.frame.size.height / 2
        userImg.contentMode = .scaleAspectFill
        self.navigationItem.title = "Add Drink"
        
        let btn1 = UIButton(type: .custom)
        btn1.setTitle("Photo Select", for: .normal)
        btn1.setTitleColor(.white, for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 45, height: 30)
        btn1.addTarget(self, action: #selector(self.openGallary), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
        
        imagePicker.delegate = self
        
    }
    
    @IBAction func add(_ sender: Any) {
        
        
        if let strDrink = nameText.text, let category = categoryText.text, let alcohol = alcoholicText.text, let instructions = instructionsText.text, let ingredient1 = ingredient1Text.text, let ingredient2 = ingredient2Text.text, let ingredient3 = ingredient3Text.text, let glass = glassText.text, let image = selectedImg?.data {
            
            
            
            let newDrink = Drinks(img: image, strDrink: "\(strDrink)",
                                  strCategory: "\(category)",
                                  strAlcoholic: "\(alcohol)",
                                  strInstructions: "\(instructions)",
                                  strIngredient1: "\(image)",
                                  strIngredient2: "\(ingredient1)",
                                  strDrinkThumb: "\(ingredient2)",
                                  strIngredient3: "\(ingredient3)",
                                  strGlass: "\(glass)")
            
            
            userDrinks.append(newDrink)
            StoreManager.shared.saveDrinks(data: userDrinks)
            
            
            
            self.navigationController?.popViewController(animated: true)
            
        }
        
    }
    
}


extension DrinkViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            let imgName = imgUrl.lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let localPath = documentDirectory?.appending(imgName)
            
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            let photoURL = URL.init(fileURLWithPath: localPath!)//NSURL(fileURLWithPath: localPath!)
            self.imageUrl = photoURL
            
            selectedImg = image
        }
        userImg.image = selectedImg
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    @objc func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
}



