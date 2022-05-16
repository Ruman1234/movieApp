//
//  MovieHomeViewController.swift
//  MovieApp
//
//  Created by Ruman on 13/05/2022.
//


import UIKit

class MovieHomeViewController: UIViewController {
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var movieArray = [MovieResultsArray]()
    var datasource : MovieHomeViewControllerDataSource?
    var viewModel : MoviesDataManabable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMovieCollectionView()
        setupViewModel()
    }
    
    private func setupMovieCollectionView(){
        datasource = MovieHomeViewControllerDataSource(withDelegate: self,movieArray: movieArray)
        moviesCollectionView.register(UINib(nibName: movieCollectionViewCellIdentifier, bundle: nil), forCellWithReuseIdentifier: movieCollectionViewCellIdentifier)
        moviesCollectionView.delegate = datasource
        moviesCollectionView.dataSource = datasource
    }
    
    private func setupViewModel(){
        viewModel = MovieHomeViewModel(delegate: self)
        viewModel?.getMoviesData()
    }
    
}

extension MovieHomeViewController : MovieHomeProtocols{
    func movieDataProvider(_ movieData: [MovieResultsArray]) {
        self.movieArray = movieData
        datasource?.movieArray = self.movieArray
        DispatchQueue.main.async {
            self.moviesCollectionView.reloadData()
        }
    }
    
    func showError(errorDesc: String) {
        self.createAlert(title: "Alert!!!", message: errorDesc)
    }
}

extension MovieHomeViewController : MovieViewControllerDelegate{
    func addRemoveMovieFromDB(isAdd: Bool, index: Int) {
        self.movieArray[index].favorite = isAdd
        datasource?.movieArray = self.movieArray
        self.viewModel?.addRemoveMovieFromDB(isAdd: isAdd, data: self.movieArray[index])
    }
    
    func selectedCell(row: Int) {
        let main = self.storyboard?.instantiateViewController(identifier: movieDetailsViewController) as! MovieDetailsViewController
        main.movie = movieArray[row]
        self.navigationController?.pushViewController(main, animated: true)
    }
}
