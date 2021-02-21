//
//  BannerTableViewCell.swift
//  Movies
//
//  Created by Orhan Erbas on 20.02.2021.
//

import UIKit
import FSPagerView

class BannerTableViewCell: UITableViewCell {

    @IBOutlet weak var pagerView: FSPagerView!
    @IBOutlet weak var bannerPageControl: UIPageControl!
    @IBOutlet weak var bannerTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureBannerCell() {
        pagerView.reloadData()
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.itemSize = FSPagerView.automaticSize
        pagerView.decelerationDistance = 1
        
        if #available(iOS 14.0, *) {
            bannerPageControl.backgroundStyle = .minimal
        }
    }

}
