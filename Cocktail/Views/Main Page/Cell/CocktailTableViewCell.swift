//
//  CocktailTableViewCell.swift
//  Cocktail
//
//  Created by Ekin Barış Demir on 10.04.2021.
//

import UIKit

class CocktailTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cocktailImage: UIImageView!
    @IBOutlet weak var cocktailName: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        colorView.layer.cornerRadius = 15
        colorView.backgroundColor = UIColor.customColor()
        cocktailImage.contentMode = .scaleAspectFill
        cocktailImage.layer.cornerRadius = cocktailImage.frame.height / 2
        cocktailName.textColor = UIColor.white
    }
    
    
    
}
