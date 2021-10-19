//
//  PlaceViewController.swift
//  GuideBookApp
//
//  Created by Irish on 10/8/21.
//

import UIKit

class PlaceViewController: UIViewController {
    
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    var place:Place?
    
    lazy var infoViewController: InfoViewController = {
        
        let infoVC = self.storyboard?.instantiateViewController(identifier: Constants.INFO_VIEWCONTROLLER) as! InfoViewController
        
        return infoVC
    }()
    
    lazy var mapViewController: MapViewController = {
        
        let infoVC = self.storyboard?.instantiateViewController(identifier: Constants.MAP_VIEWCONTROLLER) as! MapViewController
        
        return infoVC
    }()
    
    lazy var notesViewController: NotesViewController = {
        
        let infoVC = self.storyboard?.instantiateViewController(identifier: Constants.NOTES_VIEWCONTROLLER) as! NotesViewController
        
        return infoVC
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let placeImageName = place?.imagename {
            placeImageView.image = UIImage(named: placeImageName)
        }
        
        placeNameLabel.text = place?.name
        
        segmentChanged(self.segmentedControl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            infoViewController.place = self.place
            switchViewController(infoViewController)
        case 1:
            mapViewController.place = self.place
            switchViewController(mapViewController)
        case 2:
            notesViewController.place = self.place
            switchViewController(notesViewController)
        default:
            infoViewController.place = self.place
            switchViewController(infoViewController)
        }
    }
    
    
    private func switchViewController(_ infoVC:UIViewController) {
        
        addChild(infoVC)
        containerView.addSubview(infoVC.view)
        infoVC.view.frame = containerView.bounds
        infoVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        infoVC.didMove(toParent: self)
    }
  
}
