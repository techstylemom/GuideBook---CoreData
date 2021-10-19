//
//  ViewController.swift
//  GuideBookApp
//
//  Created by Irish on 10/8/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var places = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the places from Core Data
        do {
            places = try context.fetch(Place.fetchRequest())
        }
        catch {
            
            // Unable to fetch data
            print("Unable to fetch data")
        }
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let selectedRow = tableView.indexPathForSelectedRow {
            
            let selectedPlace = self.places[selectedRow.row]
            
            let placeVC = segue.destination as! PlaceViewController
            
            placeVC.place = selectedPlace
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath) as! PlaceTableViewCell
        
        cell.setCell(places[indexPath.row])
        
        return cell
    }
    
}

