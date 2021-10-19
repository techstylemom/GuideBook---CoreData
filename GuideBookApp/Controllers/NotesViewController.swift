//
//  NotesViewController.swift
//  GuideBookApp
//
//  Created by Irish on 10/8/21.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var place:Place?
    var fetchedNotesRC: NSFetchedResultsController<Note>?
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refresh()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
   
    @IBAction func addNoteTapped(_ sender: UIButton) {
        
        goToAddNoteVC()
        
    }
    
    func refresh() {
        // Check if there a place set
        if let place = place {
            
            // Get a fetch request for the places
            let request: NSFetchRequest<Note> = Note.fetchRequest()
            request.predicate = NSPredicate(format: "place = %@", place)
            
            // Set a sort descriptor
            let sort = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [sort]
            
            // Create a fetched results controller
            fetchedNotesRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            
            // Execute fetch
            do {
                try fetchedNotesRC!.performFetch()
            } catch {
                // Unable to fetch
            }
            
            // Tell table view to request data
            tableView.reloadData()
        }
    }
    
    func goToAddNoteVC(_ indexPath: IndexPath? = nil) {
        
        // Display the popup
        let addNoteVC = storyboard?.instantiateViewController(identifier: Constants.ADDNOTES_VIEWCONTROLLER) as! AddNoteViewController
        
        addNoteVC.delegate = self
        
        if let indexPath = indexPath {
            addNoteVC.note = self.fetchedNotesRC?.object(at: indexPath)
        }
        
        addNoteVC.place = place
        
        // Configure the pop-up mode
        addNoteVC.modalPresentationStyle = .overCurrentContext
        
        present(addNoteVC, animated: true, completion: nil)
    }
}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedNotesRC?.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NOTE_CELL, for: indexPath)
        
        let note = fetchedNotesRC?.object(at: indexPath)
        
        if let note = note {
            
            let format = DateFormatter()
            format.dateFormat = "MMM d, yyy - h:mm a"
            let newDate = format.string(from: note.date!)
            
            cell.textLabel?.text = note.text
            cell.detailTextLabel?.text = newDate
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        goToAddNoteVC(indexPath)
       
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
            
            if self.fetchedNotesRC == nil {
                return
            }
            
            let note = self.fetchedNotesRC!.object(at: indexPath)
            
            self.context.delete(note)
            
            do {
                try self.context.save()
                self.refresh()
            } catch {
                // Unable to save
            }
        
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension NotesViewController: AddNoteViewControllerDelegate {
    
    func noteAdded() {
        refresh()
    }
}
