//
//  HomeTableViewCell.swift
//  Movies
//
//  Created by Orhan Erbas on 20.02.2021.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var shortDescription: UILabel!
    @IBOutlet weak var date: UILabel!
    
    var post: UpComingViewModel! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        self.title.text = post.title
        self.shortDescription.text = post.overview
        self.date.text = post.release_date
        productImg.layer.cornerRadius = 5
        productImg.layer.masksToBounds = true
        
        let url = post.poster_path
        productImg.kf.setImage(with: url)
    }

}
