//
//  InfoViewController.swift
//  GuideBookApp
//
//  Created by Irish on 10/8/21.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var summaryLabel: UILabel!
    
    var place:Place?
    
    override func viewWillAppear(_ animated: Bool) {
        
        summaryLabel.text = place?.summary
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    

}
