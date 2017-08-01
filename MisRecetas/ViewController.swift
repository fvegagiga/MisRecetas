//
//  ViewController.swift
//  MisRecetas
//
//  Created by Fernando Vega Giganto on 31/7/17.
//  Copyright © 2017 Fernando Vega Giganto. All rights reserved.
//

import UIKit

class ViewController: UITableViewController { 

    var recipes : [Recipe] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var recipe = Recipe(name: "Tortilla de patata", image : #imageLiteral(resourceName: "tortilla"),
                            time: 20,
                            ingredients:["Patatas", "Huevos", "Cebolla"],
                            steps: ["Pelar las patatas y la cebolla",
                                    "Cortar las patatas y la cebolla y sofreir",
                                    "Batir los huevos y echarlos durante 1 minuto a la sartén con el resto"])
        recipes.append(recipe)
        
        recipe = Recipe(name: "Pizza", image : #imageLiteral(resourceName: "pizza"),
                        time: 60,
                        ingredients:["Masa", "Tomate", "Peperonni", "lechuga"],
                        steps: ["Estender la masa",
                                "extender ingredientes",
                                "Hornear"])
        recipes.append(recipe)
 
        recipe = Recipe(name: "Hamburguesa con queso", image: #imageLiteral(resourceName: "hamburguesa"),
                        time: 20,
                        ingredients:["Pan", "Carne", "Verduras", "Queso", "Pepinillo"],
                        steps: ["Cortar verduras",
                                "Colocar ingredientes",
                                "Comer"])
        recipes.append(recipe)
        
        recipe = Recipe(name: "Ensalada César", image: #imageLiteral(resourceName: "ensalada"),
                        time: 20,
                        ingredients:["Lechuga", "Pollo", "Salsa"],
                        steps: ["Cortar pollo",
                                "Mezclar salsa cesar",
                                "Batir los ingredientes"])
        recipes.append(recipe)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe = recipes[indexPath.row]
        let cellID = "RecipeCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! RecipeCell
        
        cell.thumbnailImageView.image = recipe.image
        cell.nameLabel.text = recipe.name
        cell.timeLabel.text = "\(recipe.time!) min"
        cell.ingredientsLabel.text = "Ingredients: \(recipe.ingredients.count)"
        
        cell.thumbnailImageView.layer.cornerRadius = 42.0
        cell.thumbnailImageView.clipsToBounds = true
        
        if recipe.isFavourite {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            self.recipes.remove(at: indexPath.row)
        }
        
        self.tableView.deleteRows(at:[indexPath], with: .fade)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // compartir
        let shareAction = UITableViewRowAction(style: .default, title: "Compartir") { (action, indexPath) in
            
            let shareDefaultText = "Estoy mirando la receta de \(self.recipes[indexPath.row].name!) en la App"
            
            let activityController = UIActivityViewController(activityItems: [shareDefaultText, self.recipes[indexPath.row].image!], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        }
        
        shareAction.backgroundColor = UIColor (red: 30.0/255.0, green: 164.0/255.0, blue: 253.0/255.0, alpha: 1.0)
        
        // Borrar
        let deleteAction = UITableViewRowAction(style: .default, title: "Borrar") { (action, indexPath) in
            self.recipes.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        deleteAction.backgroundColor = UIColor (red: 202.0/255.0, green: 202.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        
        return [shareAction, deleteAction]
    }
    
    
    
    
    //MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let recipe = self.recipes[indexPath.row]
        
        let alertController =  UIAlertController(title: nil, message: "Valora este plato", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        var favoriteActionTitle = "Favorito"
        var favouriteActionStyle = UIAlertActionStyle.default
        
        if recipe.isFavourite {
            favoriteActionTitle = "No favorito"
            favouriteActionStyle = UIAlertActionStyle.destructive
        }
        
        
        
        let favouriteAction = UIAlertAction(title: favoriteActionTitle, style: favouriteActionStyle) { (action) in
            let recipe = self.recipes[indexPath.row]
            recipe.isFavourite = !recipe.isFavourite
            self.tableView.reloadData()
        }
        alertController.addAction(favouriteAction)
        
        self.present(alertController, animated: true, completion: nil)
    }



    
}

