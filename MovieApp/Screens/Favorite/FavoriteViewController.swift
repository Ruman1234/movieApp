//
//  ViewController.swift
//  MovieApp
//
//  Created by Ruman on 13/05/2022.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteCollectionViewCell: UICollectionView!
    
    var movieArray = [MovieResultsArray]()
    var datasource : MovieHomeViewControllerDataSource?
    var viewModel : MoviesDataManabable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMovieCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func setupMovieCollectionView(){
        datasource = MovieHomeViewControllerDataSource(withDelegate: self, movieArray: movieArray)
        favoriteCollectionViewCell.delegate = datasource
        favoriteCollectionViewCell.dataSource = datasource
        favoriteCollectionViewCell.register(UINib(nibName: movieCollectionViewCellIdentifier, bundle: nil), forCellWithReuseIdentifier: movieCollectionViewCellIdentifier)
    }
    
    private func setupViewModel(){
        viewModel = FavoriteeViewModel(delegate: self)
        viewModel?.getMoviesData()
    }
    
    private func reloadCollectionView(){
        datasource?.movieArray = self.movieArray
        DispatchQueue.main.async {
            self.favoriteCollectionViewCell.reloadData()
        }
    }
}

extension FavoriteViewController : MovieHomeProtocols{
    func movieDataProvider(_ movieData: [MovieResultsArray]) {
        self.movieArray = movieData
        reloadCollectionView()
    }
    func showError(errorDesc: String) {
        self.createAlert(title: "Alert!!!", message: errorDesc)
    }
}

extension FavoriteViewController : MovieViewControllerDelegate{
    func addRemoveMovieFromDB(isAdd: Bool, index: Int) {
        self.viewModel?.addRemoveMovieFromDB(isAdd: isAdd, data: self.movieArray[index])
        self.movieArray.remove(at: index)
        reloadCollectionView()
    }
    
    func selectedCell(row: Int) {
        let main = self.storyboard?.instantiateViewController(identifier: movieDetailsViewController) as! MovieDetailsViewController
        main.movie = movieArray[row]
        self.navigationController?.pushViewController(main, animated: true)
    }
}
