//
//  ViewController.swift
//  SpaceTrivia
//
//  Created by Athlosn90 on 22/04/2021.
//  Copyright © 2021 AndreaSanna. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var CategoriesButton: UIButton!
    @IBOutlet weak var LearnButton: UIButton!
    @IBOutlet weak var QuitButton: UIButton!
    
    var cancellable: AnyCancellable? = nil
    let vm = GameViewModel(data: GameModel())
    let counterClass = Counter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       cancellable = vm.publisher.sink(receiveCompletion: { (something) in
            print(something)
        }) { (value) in
            print(value)
            self.StartButton.setTitle(value, for: .normal)
        }
        vm.changeTitle()

    }

    @IBAction func Start(_ sender: Any) {
        
        
        
    }
    
    
    @IBAction func QuitApp(_ sender: Any) {
        
//        alert before quit
        let alert = UIAlertController(title: "Close?", message: "Are you Sure You Want To Exit?", preferredStyle: .alert)
        let close = UIAlertAction(title: "Close", style: .destructive) { (UIAlertAction) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    exit(0)
                }
            }
            
        }
        
        let stay = UIAlertAction(title: "No Way", style: .cancel) { (UIAlertAction) in
            
            alert.dismiss(animated: true, completion: nil)
            
        }
        
        alert.addAction(close)
        alert.addAction(stay)
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
}

