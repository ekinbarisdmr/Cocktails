//
//  DetailTableViewCell.swift
//  Cocktail
//
//  Created by Ekin Barış Demir on 10.04.2021.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cocktailImage: UIImageView!
    @IBOutlet weak var cocktailName: UILabel!
    @IBOutlet weak var cocktailAlcoholic: UILabel!
    @IBOutlet weak var cocktailCategory: UILabel!
    @IBOutlet weak var cocktailCategoryResponse: UILabel!
    @IBOutlet weak var cocktailGlass: UILabel!
    @IBOutlet weak var cocktailGlassResponse: UILabel!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var cocktailIngredients: UILabel!
    @IBOutlet weak var cocktailIngredientsDetails: UILabel!
    @IBOutlet weak var cocktailInstructions: UILabel!
    @IBOutlet weak var cocktailInstructionDetail: UILabel!
    @IBOutlet weak var cancelButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cocktailImage.layer.cornerRadius = cocktailImage.frame.height / 2
        cocktailImage.contentMode = .scaleAspectFill
        cocktailName.sizeToFit()
        cocktailIngredientsDetails.sizeToFit()
        cocktailIngredientsDetails.numberOfLines = 0
        colorView.backgroundColor = UIColor.customColor()
        colorView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 20)
        
    }

    
}
