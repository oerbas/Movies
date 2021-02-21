//
//  ViewController.swift
//  Movies
//
//  Created by Orhan Erbas on 20.02.2021.
//

import UIKit
import FSPagerView

class ViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pagerView: FSPagerView!
    @IBOutlet weak var bannerPageControl: UIPageControl!
    

    private var UpComingModel : UpComingListViewModel!
    private var NowPlayingModel : NowPlayingListViewModel!
    private var fsPageControl : FSPageControl!
    
    @IBOutlet weak var detailVie: UIView!
    @IBOutlet weak var subviewLAbel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        pagerView.delegate = self
        pagerView.dataSource = self
        navigationController?.navigationBar.isHidden = true
        updateData()
    }
    
    func updateData() {
        
        ApiManager.instance.getUpComingList(success: { result in
            self.UpComingModel = UpComingListViewModel(moviesList: result!)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        ApiManager.instance.getNowPlayingList(success: { result in
            self.NowPlayingModel = NowPlayingListViewModel(moviesList: result!)
            DispatchQueue.main.async {
                self.configurePagerView()
            }
        })
    }
    
    func configurePagerView() {
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

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.UpComingModel == nil ? 0 : self.UpComingModel.numberOfRowSelection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableViewCell
            cell.accessoryType = .disclosureIndicator
            let UpComingModels = UpComingModel.moviesAtIndex(indexPath.row)
            cell.post = UpComingModels
            return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MoviesDetailVC") as! MoviesDetailVC
        let upcomingMovie = UpComingModel.moviesAtIndex(indexPath.row)
        vc.modalPresentationStyle = .fullScreen
        vc.movieId = upcomingMovie.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: FSPagerViewDelegate, FSPagerViewDataSource {
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        bannerPageControl.numberOfPages = self.NowPlayingModel == nil ? 0 : self.NowPlayingModel.numberOfRowSelection()
        return self.NowPlayingModel == nil ? 0 : self.NowPlayingModel.numberOfRowSelection()
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let upcomingModel = NowPlayingModel.moviesAtIndex(index)
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let url = upcomingModel.poster_path
        cell.imageView?.kf.setImage(with: url)
        cell.addSubview(detailVie)
        subviewLAbel.text = upcomingModel.title
        bannerPageControl.currentPage = index
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MoviesDetailVC") as! MoviesDetailVC
        let upcomingMovie = NowPlayingModel.moviesAtIndex(index)
        vc.modalPresentationStyle = .fullScreen
        vc.movieId = upcomingMovie.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
