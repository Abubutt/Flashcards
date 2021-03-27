//
//  ViewController.swift
//  Flashcards
//
//  Created by Abu Butt on 2/20/21.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}
class ViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var card: UIView!
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    var count = 0
    var x = 300.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readSavedFlashcards()
        if flashcards.count == 0{
            updateFlashcard(question: "Who is the president of America", answer: "Joe Biden")
        }
        else{
            updateLabels()
            updateNextPrevButtons()
        }
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        
        flipFlashcard()
        
    }
    func flipFlashcard(){
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            if self.count == 0{
                self.frontLabel.isHidden = true
                self.count = self.count + 1
            }
            else{
                self.count = 0
                self.frontLabel.isHidden = false
            }
        })

    
    }
    
    func updateFlashcard(question: String, answer: String) {
        let flashcard = Flashcard(question: question, answer: answer)
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        
        flashcards.append(flashcard)
        print("Added new flashcard")
        print("Now we have \(flashcards.count) flashcards")
        
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        
        updateNextPrevButtons()
        
        
        saveAllFlashcardsToDisk()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        
        
        updateNextPrevButtons()
        animateCardOut(num: -300.0)
    }
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        
        
        updateNextPrevButtons()
        animateCardOut(num: Float(x))
    }
    
    func updateNextPrevButtons() {
        if currentIndex == flashcards.count - 1{
            nextButton.isEnabled = false
        }
        else{
            nextButton.isEnabled = true
        }
        
    }
    
    func updateLabels(){
        
        let currentFlashcard = flashcards[currentIndex]
        
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        
    }
    
    func saveAllFlashcardsToDisk(){
        
        let dictionaryArray = flashcards.map{ (card) -> [String:String] in return ["question": card.question, "answer": card.answer]}
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards(){
        
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]]{
            let savedCards = dictionaryArray.map{dictionary -> Flashcard in return Flashcard(question:dictionary["question"]!, answer: dictionary["answer"]!)}
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    func animateCardOut(num:Float){
        UIView.animate(withDuration: 0.2,  animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: CGFloat((-1.0*num)), y: 0.0)
        }, completion: { finished in
            self.updateLabels()
            
            self.animateCardIn(num:num)
        })
    }
    
    func animateCardIn(num:Float){
        card.transform = CGAffineTransform.identity.translatedBy(x: CGFloat(num), y: 0.0)
        UIView.animate(withDuration: 0.2){
            self.card.transform = CGAffineTransform.identity
        }
    }
}

