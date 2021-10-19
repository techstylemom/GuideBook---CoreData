//
//  PlaceTableViewCell.swift
//  GuideBookApp
//
//  Created by Irish on 10/8/21.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Style the cell
        cardView.layer.cornerRadius = 5
        shadowView.layer.cornerRadius = 5
        shadowView.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCell(_ p: Place) {
        
        // Set the image
        if p.imagename != nil {
            self.placeImageView.image = UIImage(named: p.imagename!)
        }

        // Set the label
        self.placeNameLabel.text = p.name
    }
}
