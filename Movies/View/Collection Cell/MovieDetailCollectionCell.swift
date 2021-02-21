//
//  MovieDetailCollectionCell.swift
//  Movies
//
//  Created by Orhan Erbas on 21.02.2021.
//

import UIKit

class MovieDetailCollectionCell: UICollectionViewCell {
    @IBOutlet weak var movieDetailLabel: UILabel!
    @IBOutlet weak var movieDetailImage: UIImageView!
    
    var  similar: SimilarViewModel! {
        didSet {
            self.updateUI()
        }
    }
    func updateUI() {
        movieDetailLabel.text = similar.title
        let url = similar.poster_path
        movieDetailImage.layer.cornerRadius = 4
        movieDetailImage.layer.masksToBounds = true
        movieDetailImage.kf.setImage(with: url)
    }
}
