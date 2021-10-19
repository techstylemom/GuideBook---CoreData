//
//  AddNoteViewController.swift
//  GuideBookApp
//
//  Created by Irish on 10/8/21.
//

import UIKit

protocol AddNoteViewControllerDelegate {
    func noteAdded()
}

class AddNoteViewController: UIViewController {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    var place:Place?
    var note:Note?
    
    var delegate:AddNoteViewControllerDelegate?
    private let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let note = self.note {
            textView.text = note.text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cardView.layer.cornerRadius = 5
        cardView.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = 5
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        dismiss(animated: true, completion: nil)
    }

    @IBAction func saveTapped(_ sender: UIButton) {
        
        if let oldNote = self.note {
            
            oldNote.text = textView.text
            
        } else {
            
            let note = Note(context: context)
            note.date = Date()
            note.text = textView.text
            note.place = place
        }
        
        do {
            try context.save()
            self.delegate?.noteAdded()
            dismiss(animated: true, completion: nil)
        } catch {
            
            // Unable to save
        }
    
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
}
