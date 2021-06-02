//
//  DetailsViewController.swift
//  Cocktail
//
//  Created by Ekin Barış Demir on 10.04.2021.
//

import UIKit
import Alamofire
import SDWebImage

class DetailsViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var drinksArray: Drinks?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestStatus = .pending
        setupTableView()
        requestStatus = .completed(nil)
        
    }
    
    func setupTableView(){
        
        tableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil),  forCellReuseIdentifier: "detailCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        self.requestStatus = .completed(nil)
        
        
    }
    
    
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
    
}

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 700
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        if let cocktailName = drinksArray!.strDrink{
            cell.cocktailName.text = cocktailName
            cell.cocktailName.numberOfLines = 0
            cell.cocktailName.sizeToFit()
            cell.cocktailName.adjustsFontSizeToFitWidth = true
        }
        
        if drinksArray!.img != nil {
            cell.cocktailImage.image = drinksArray!.img?.image
            
        }
        else {
            
            
            if let url = drinksArray!.strDrinkThumb, let imageUrl = URL(string: url) {
                
                cell.cocktailImage.sd_setImage(with: imageUrl, completed: nil)
            }
            
        }
        
        if let alcoholic = drinksArray!.strAlcoholic{
            cell.cocktailAlcoholic.text = alcoholic
            
        }
        
        if let glass = drinksArray!.strGlass {
            cell.cocktailGlassResponse.text = glass
            
        }
        
        if let category = drinksArray!.strCategory {
            cell.cocktailCategoryResponse.text = category
            
        }
        
        if let instruction = drinksArray!.strInstructions {
            cell.cocktailInstructionDetail.text = instruction
        }
        
        
        cell.cocktailIngredientsDetails.sizeToFit()
        cell.cocktailIngredientsDetails.numberOfLines = 0
        cell.cocktailIngredientsDetails.adjustsFontSizeToFitWidth = true
        cell.cocktailIngredientsDetails.lineBreakMode = .byWordWrapping
        
        cell.cocktailIngredientsDetails.text = "\(drinksArray!.strIngredient1!)\n\(drinksArray!.strIngredient2!)\n\(drinksArray!.strIngredient3!)"
        
        
        
        cell.cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        return cell
        
    }
    
    
}
