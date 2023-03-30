//
//  HeroesTableViewCell.swift
//  HeroisMarvel
//
//  Created by Jeferson Dias dos Santos on 09/10/22.
//  Copyright © 2022 Eric Brito. All rights reserved.
//

import UIKit
import Kingfisher

class HeroesTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var ivThumb: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDescription: UILabel!


    //MARK: - SetupCell
    func setupCell(with hero: Hero) {
        lbName.text = hero.name
        lbDescription.text = hero.description
        if let url = URL(string: hero.thumbnail.url) {
            ivThumb.kf.indicatorType = .activity
            ivThumb.kf.setImage(with: url)
        } else {
            ivThumb.image = nil
        }
        
        ivThumb.layer.cornerRadius = ivThumb.frame.size.height/2
        ivThumb.layer.borderColor = UIColor.red.cgColor
        ivThumb.layer.borderWidth = 2
        
    }

}
