//
//  CocktailViewController.swift
//  Cocktail
//
//  Created by Ekin Barış Demir on 10.04.2021.
//

import UIKit
import SDWebImage
import Alamofire

class CocktailViewController: BaseViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var drinksArray: [Drinks] = []
    var searchResults: [Drinks] = []
    var userDrinks: [Drinks] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestStatus = .pending
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
        setSetups()
        searchController.searchBar.text = ""
        searchController.isActive = false
        
    }
    
    
    @objc func didTapAdd() {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        if let vc = mainStoryboard.instantiateViewController(withIdentifier: "DrinkViewController") as? DrinkViewController{
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    func setSetups(){
        setupNavigationBar()
        setupTableView()
        setSearchBar()
        get()
        
    }
    
    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.customColor()
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController!.setStatusBar(backgroundColor: UIColor.customColor())
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        definesPresentationContext = true
        self.navigationItem.title = "Cocktails"
        self.navigationItem.searchController = searchController
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        
    }

    
    func setSearchBar() {
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Medium", size: 13.0)!])
        searchController.searchBar.searchTextField.textColor = .white
        searchController.searchBar.searchTextField.font = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
        searchController.dimsBackgroundDuringPresentation = false
        let attributes:[NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "HelveticaNeue-Bold", size: 18.0) ?? UIFont.systemFont(ofSize: 18.0)
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        searchController.searchBar.delegate = self
    }
    
    func setupTableView() {
        
        tableView.register(UINib(nibName: "CocktailTableViewCell", bundle: nil), forCellReuseIdentifier: "cocktailCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func get() {
        
        Alamofire.request("https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita", method: .get).responseJSON { [self]
            response in
            if let data = response.data{
                
                do {
                    
                    let answer = try JSONDecoder().decode(DrinksResponse.self, from: data)
                    
                    if let getList = answer.drinks{
                        self.drinksArray = getList
                        userDrinks = StoreManager.shared.getDrinks()
                        
                        for drink in userDrinks {
                            drinksArray.insert(drink, at: 0)
                        }
                        self.requestStatus = .completed(nil)
                        
                    }
                    else {
                        return
                        
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.requestStatus = .completed(nil)
                    }
                    
                }
                catch {
                    print(error.localizedDescription)
                }
                
            }
        }
        
    }
    
}

extension CocktailViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive == true && searchController.searchBar.text != "" {
            return searchResults.count
        }
        else {
            return drinksArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let drink = drinksArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailCell", for: indexPath) as! CocktailTableViewCell
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        
        
        if searchController.isActive == true && searchController.searchBar.text != "" {
            
            if searchResults[indexPath.row].img != nil {
                cell.cocktailImage.image = searchResults[indexPath.row].img?.image
            }
            else {
                if let url = searchResults[indexPath.row].strDrinkThumb, let imageUrl = URL(string: url)    {
                    cell.cocktailImage.sd_setImage(with: imageUrl, completed: nil)
                }
            }
            
            if let cocktailName = searchResults[indexPath.row].strDrink{
                cell.cocktailName.text = cocktailName
            }
        }
        else {
            
            if drink.img != nil {
                cell.cocktailImage.image = drink.img?.image
            }
            else {
                
                if let url = drink.strDrinkThumb, let imageUrl = URL(string: url) {
                    cell.cocktailImage.sd_setImage(with: imageUrl, completed: nil)
                }
                
            }
            
            if let cocktailName = drink.strDrink {
                cell.cocktailName.text = cocktailName
            }
            
            
        }
        
        return cell
    }
    
    func showDetails(indexPath: IndexPath){
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        if let viewController = mainStoryboard.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController{
            
            viewController.modalPresentationStyle = .fullScreen
            viewController.drinksArray = drinksArray[indexPath.row]
            self.present(viewController, animated: true, completion: nil)
            
        }
        
    }
    
}


extension CocktailViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.showDetails(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            drinksArray.remove(at: indexPath.row)
            StoreManager.shared.saveDrinks(data: drinksArray)
            self.tableView.reloadData()
        }
    }
    
}


extension CocktailViewController: UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        searchResults = drinksArray.filter({ (drinksResponse) -> Bool in
            let match = drinksResponse.strDrink?.range(of: searchText, options: .caseInsensitive)
            
            return (match != nil)
        })
        
        tableView.reloadData()
        
    }
    
}




