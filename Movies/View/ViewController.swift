//
//  ViewController.swift
//  Movies
//
//  Created by Orhan Erbas on 20.02.2021.
//

import UIKit
import FSPagerView

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pagerView: FSPagerView!
    @IBOutlet weak var bannerPageControl: UIPageControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchBarTableView: UITableView!
    @IBOutlet weak var sViewHeight: NSLayoutConstraint!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var subviewLAbel: UILabel!
    
    private var UpComingModel : UpComingListViewModel!
    private var NowPlayingModel : NowPlayingListViewModel!
    private var SearchModel : SearchListViewModel!
    private var fsPageControl : FSPageControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        pagerView.delegate = self
        pagerView.dataSource = self
        searchBarTableView.delegate = self
        searchBarTableView.dataSource = self
        searchBar.delegate = self
        navigationController?.navigationBar.isHidden = true
        searchBarView.isHidden = true
        sViewHeight.constant = 0
        updateData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchBarView.isHidden = true
        sViewHeight.constant = 0
        searchBar.endEditing(true)
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
 
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        sViewHeight.constant = 0
        searchBarView.isHidden = true
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchBarTableView {
            return self.SearchModel == nil ? 0 : self.SearchModel.numberOfRowSelection()
        } else {
            return self.UpComingModel == nil ? 0 : self.UpComingModel.numberOfRowSelection()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == searchBarTableView {
            let secondCell =  tableView.dequeueReusableCell(withIdentifier: "SearcBarTableViewCell", for: indexPath)
            let searchModel = SearchModel.moviesAtIndex(indexPath.row)
            secondCell.accessoryType = .disclosureIndicator
            secondCell.textLabel?.text = searchModel.title
            return secondCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableViewCell
            cell.accessoryType = .disclosureIndicator
            let UpComingModels = UpComingModel.moviesAtIndex(indexPath.row)
            cell.post = UpComingModels
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == searchBarTableView {
            searchBarTableView.deselectRow(at: indexPath, animated: true)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MoviesDetailVC") as! MoviesDetailVC
            let upcomingMovie = SearchModel.moviesAtIndex(indexPath.row)
            vc.modalPresentationStyle = .fullScreen
            vc.movieId = upcomingMovie.id
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
                tableView.deselectRow(at: indexPath, animated: true)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MoviesDetailVC") as! MoviesDetailVC
                let upcomingMovie = UpComingModel.moviesAtIndex(indexPath.row)
                vc.modalPresentationStyle = .fullScreen
                vc.movieId = upcomingMovie.id
                self.navigationController?.pushViewController(vc, animated: true)
        }
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
        cell.addSubview(sliderView)
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

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.count > 2 {
            self.sViewHeight.constant = 445
            self.searchBarView.isHidden = false
            ApiManager.instance.getSearchResult(q: searchBar.text ?? "" ,success: { result in
                self.SearchModel = SearchListViewModel(moviesList: result!)
                DispatchQueue.main.async {
                    self.searchBarTableView.reloadData()
                }
            })
        } else {
            self.sViewHeight.constant = 0
        }
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBarView.isHidden = true
        searchBar.endEditing(true)
        sViewHeight.constant = 445
    }
}
