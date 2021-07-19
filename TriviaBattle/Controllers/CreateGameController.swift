//
//  CreateGameController.swift
//  TriviaBattle
//
//  Created by Athlosn90 on 08/06/2021.
//  Copyright © 2021 AndreaSanna. All rights reserved.
//

import Foundation
import UIKit

class CreateGameController: UIViewController {
    
    
    var startingSeconds = Int()
    
    
    @IBOutlet weak var Fifteen: UIButton!
    @IBOutlet weak var Thirty: UIButton!
    @IBOutlet weak var Fortyfive: UIButton!
    
    @IBAction func FifteenTap(_ sender: UIButton) {
      
        setStartingTimer(sender: sender)
        
    }
    
    @IBAction func ThirtyTap(_ sender: UIButton) {
        
        setStartingTimer(sender: sender)
        
    }
    
    @IBAction func fortyfiveTap(_ sender: UIButton) {
        
        setStartingTimer(sender: sender)
        
    }
    
    func setStartingTimer(sender: UIButton) {
        
        if sender.isTouchInside {

            startingSeconds = Int(sender.currentTitle!) ?? 0
            print(startingSeconds)
            
            if startingSeconds == 15 {
                Fifteen.backgroundColor = .green
                Thirty.backgroundColor = .clear
                Fortyfive.backgroundColor = .clear
            }
            if startingSeconds == 30 {
                Thirty.backgroundColor = .green
                Fifteen.backgroundColor = .clear
                Fortyfive.backgroundColor = .clear
            }
            if startingSeconds == 45 {
                Fortyfive.backgroundColor = .green
                Thirty.backgroundColor = .clear
                Fifteen.backgroundColor = .clear
            }
                  
        } else {
                sender.backgroundColor = .clear
        }
    }
    
}
