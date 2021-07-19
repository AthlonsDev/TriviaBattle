
//
//  LearnCOntroller.swift
//  SpaceTrivia
//
//  Created by Athlosn90 on 15/05/2021.
//  Copyright © 2021 AndreaSanna. All rights reserved.
//

import Foundation
import UIKit

class LearnController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    let categoriesData = ["Space", "History", "Nature", "Art"]
    
    override func viewDidLoad() {
        
        setCollectionDelegates()
        
    }
    
}
