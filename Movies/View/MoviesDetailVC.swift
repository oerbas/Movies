//
//  MoviesDetailVC.swift
//  Movies
//
//  Created by Orhan Erbas on 21.02.2021.
//

import UIKit
import FSPagerView

class MoviesDetailVC: UIViewController {
    @IBOutlet weak var moviesImage: UIImageView!
    @IBOutlet weak var moviesTitle: UILabel!
    @IBOutlet weak var moviesDescription: UILabel!
    @IBOutlet weak var moviesViewConstant: NSLayoutConstraint!
    @IBOutlet weak var moviesDate: UILabel!
    @IBOutlet weak var moviesImdb: UILabel!
    @IBOutlet weak var imdbIcon: UIImageView!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var movieId: Int!
    private var Movie : MovieDetailModel!
    private var SimilarMovie : SimilarListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }
  
    func updateData() {
        ApiManager.instance.getMovieDetail(movieId: movieId, success: { result in
            self.Movie = MovieDetailModel(result: result!)
            DispatchQueue.main.async {
                let url = self.Movie.poster_path
                self.moviesImage.kf.setImage(with: url)
                self.moviesTitle.text = self.Movie.title
                self.moviesDescription.text = self.Movie.result.overview
                self.moviesDescription.sizeToFit()
                self.moviesDescription.preferredMaxLayoutWidth = 500
                self.moviesDate.text = self.Movie.release_date
                self.moviesImdb.text = "\(self.Movie.rating)"
            }
        })
        
        ApiManager.instance.getSimilarList(movieId: movieId, success: { result in
            self.SimilarMovie = SimilarListViewModel(moviesList: result!)
            DispatchQueue.main.async {
                self.moviesCollectionView.reloadData()
            }
        })
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.openImdb))
        imdbIcon.addGestureRecognizer(recognizer)
        navigationController?.navigationBar.isHidden = true
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func openImdb() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        vc.imdbID = self.Movie.imdb_id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MoviesDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.SimilarMovie == nil ? 0 : self.SimilarMovie.numberOfRowSelection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieDetailCollectionCell", for: indexPath) as! MovieDetailCollectionCell
        let similar = SimilarMovie.moviesAtIndex(indexPath.row)
        cell.similar = similar
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MoviesDetailVC") as! MoviesDetailVC
        let similar = SimilarMovie.moviesAtIndex(indexPath.row)
        vc.modalPresentationStyle = .fullScreen
        vc.movieId = similar.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
