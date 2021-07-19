//
//  CategoriesController.swift
//  SpaceTrivia
//
//  Created by Athlosn90 on 28/04/2021.
//  Copyright © 2021 AndreaSanna. All rights reserved.
//

import Foundation
import UIKit

class CategoryController: UIViewController {
    
    
    
    @IBAction func Space(_ sender: UIButton) {
//        performSegue(withIdentifier: "Space", sender: self)
    }
    
    @IBAction func History(_ sender: UIButton) {
//        performSegue(withIdentifier: "History", sender: self)
    }
    
    @IBAction func Nature(_ sender: UIButton) {
//        performSegue(withIdentifier: "Nature", sender: self)
    }
    
    @IBAction func Art(_ sender: UIButton) {
//        performSegue(withIdentifier: "Art", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as! GameController
        switch segue.identifier {
        case "Space":
            destination.Category = "Space"
            destination.isShuffled = false
        case "History":
            destination.Category = "History"
            destination.isShuffled = false
        case "Nature":
            destination.Category = "Nature"
            destination.isShuffled = false
        case "Art":
            destination.Category = "Art"
            destination.isShuffled = false
        default:
            break
        }
    }
}
