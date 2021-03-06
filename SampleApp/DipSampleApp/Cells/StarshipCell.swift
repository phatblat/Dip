//
//  StarshipCell.swift
//  Dip
//
//  Created by Olivier Halligon on 09/10/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import UIKit

final class StarshipCell : UITableViewCell, FillableCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var crewLabel: UILabel!
    @IBOutlet weak var passengersLabel: UILabel!
    
    let numberFormatter = NSNumberFormatter()
    
    func fillWithObject(starship: Starship) {
        nameLabel.text = starship.name
        modelLabel.text = starship.model
        manufacturerLabel.text = starship.manufacturer
        crewLabel.text = numberFormatter.stringFromNumber(starship.crew)
        passengersLabel.text = numberFormatter.stringFromNumber(starship.passengers)
    }
}
