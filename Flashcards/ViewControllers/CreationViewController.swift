//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Abu Butt on 3/6/21.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: ViewController!
    
    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var answerTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        
        flashcardsController.updateFlashcard(question: questionText!, answer: answerText!)
        
        dismiss(animated: true)
    }
    

}
