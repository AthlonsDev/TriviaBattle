//
//  GameController.swift
//  SpaceTrivia
//
//  Created by Athlosn90 on 22/04/2021.
//  Copyright © 2021 AndreaSanna. All rights reserved.
//

import Foundation
import UIKit
import Combine

class GameController: UIViewController {
    
    @IBOutlet weak var CategoryL: UILabel!
    @IBOutlet weak var Question: UILabel!
    @IBOutlet weak var RoundL: UILabel!
    @IBOutlet weak var ScoreLbl: UILabel!
    @IBOutlet weak var RecordLbl: UILabel!
    @IBOutlet var Answers: [UIButton]!
    @IBOutlet weak var TimerLbl: UILabel!
    @IBOutlet weak var QuestionImage: UIImageView!
    
    
    var viewModel = [GameViewModel]()
    var correctAnswer = String()
    var questionNumber = Int()
    var Round = Int()
    var Score = Int()
    var isShuffled: Bool = true
    var Category: String?
    var questionsIDs = [0, 1, 2]
    var shuffle = [Int]()
    
    var addingTime = false
        
    private var switchSubscriber: AnyCancellable?
    
    override func viewDidLoad() {
            
        setupLevel()

        
   
    }
    
    func setupProcessingChain() {

        
    }
    
    func setupLevel() {
         getData()
        
        shuffle = questionsIDs.shuffled()
            
        Round = 1
                      
        RoundL.text = "Round \(String(describing: Round))"
              
        print("Question number: \(self.questionNumber)")
        
        if isShuffled == true {
            setupCategory()
        }
        setupProcessingChain()
        
        CategoryL.text = Category
        
        StartTimer()
        
    }

    
    @IBAction func Button1(_ sender: UIButton) {
        self.answerQuestion(sender: sender)
    }
    
    @IBAction func Button2(_ sender: UIButton) {
        self.answerQuestion(sender: sender)
    }
    
    @IBAction func Button3(_ sender: UIButton) {
        self.answerQuestion(sender: sender)
    }
    
    @IBAction func Button4(_ sender: UIButton) {
        self.answerQuestion(sender: sender)
    }
    
    
    func answerQuestion(sender: UIButton) {
        if sender.currentTitle == correctAnswer {
            print("Correct Answer, load new question")
            sender.backgroundColor = .green
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (Timer) in
                self.questionNumber += 1
                self.Score += 1
                self.addTime()
                self.ScoreLbl.text = "Score: \(String(self.Score))"
                self.loadNewData()
                if self.isShuffled == true {
                    self.setupCategory()
                }
                
                if self.questionNumber == 3 {
                    self.Round += 1
                    self.addTime()
                    self.RoundL.text = "Round \(String(describing: self.Round))"
                    self.questionNumber = 0
                    self.loadNewData()
                }
                
            }
            
        } else {
            sender.backgroundColor = .red
            let alert = UIAlertController(title: "Wrong!", message: "Ha HA HA! You Need To Study More", preferredStyle: .alert)
            let close = UIAlertAction(title: "Close", style: .cancel) { (UIAlertAction) in
                
                self.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
                
            }
            let retry = UIAlertAction(title: "Try Again", style: .default) { (UIAlertAction) in
                           
//                 TODO:Set score back to zero
                self.setupLevel()
                           
            }
            let quit = UIAlertAction(title: "Rage Quit", style: .destructive) { (UIAlertAction) in
                           
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        exit(0)
                    }
                }
                           
            }
            
            alert.addAction(close)
            alert.addAction(retry)
            alert.addAction(quit)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    let counterClass = Counter()
     
  
    
    
 
}



extension GameController {
    
    func setupCategory() {
        
        Category = nil
        var cateogries = ["Space", "History", "Nature", "Art"]
        cateogries.shuffle()
        Category = cateogries[0]
        CategoryL.text = Category
        
    }
    
    
    func getData() {
        let vm = GameViewModel(data: GameModel())
        
        
            vm.fetchData {

                self.viewModel = $0.map({return GameViewModel(data: $0)})
                
                self.loadNewData()
                
            }
        
        }


    func loadNewData() {
        let vm = GameViewModel(data: GameModel())
        vm.LoadQuestions(data: self.viewModel, number: self.questionNumber, shuffle: self.shuffle, round: Round, category: Category!) { (data) in
                            
                for i in self.Answers {
                    i.backgroundColor = .lightGray
                }
                            
//                self.CategoryL.text = data.Category
                self.Question.text = data.Question
                self.correctAnswer = data.correctAnswer
                            
                let shuffle = self.Answers.shuffled()
                            
                shuffle[0].setTitle(data.Answer1, for: .normal)
                shuffle[1].setTitle(data.Answer2, for: .normal)
                shuffle[2].setTitle(data.Answer3, for: .normal)
                shuffle[3].setTitle(data.Answer4, for: .normal)
            
                print(data.image )
                if let Image = data.image {
                    vm.processImage(image: Image) { (image) in
                        
                        self.QuestionImage.image = image
                }
            }
           
                            
        }
                        
    }
    
    
}

