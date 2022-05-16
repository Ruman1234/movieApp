//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Ruman on 13/05/2022.
//

import UIKit


class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var textViewDesc: UITextView!
    @IBOutlet weak var btnFav: UIButton!
    
    var movie : MovieResultsArray?
    var viewModel : MovieDetailsDelegate?
    private var isOn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie {
            isOn = movie.favorite ?? false
            setupView(movie: movie)
            self.btnFav.setButtonBackGround(on: UIImage(systemName: "heart.fill")!, off: UIImage(systemName: "heart")!, onOffStatus: isOn)
        }
        setupViewModel()
    }

    func setupView(movie :MovieResultsArray ){
        lblTitle.text = movie.title
        lblReleaseDate.text = movie.release_date
        textViewDesc.text = movie.overview
        if let url = URL(string: "https://image.tmdb.org/t/p/w92\(movie.backdrop_path ?? "")"){
            imgBanner.load(url: url)
        }
    }

    func setupViewModel(){
        viewModel = MovieDetailsViewModel(delegate: self)
    }
    
    @IBAction func btnFavPressed(_ sender: UIButton) {
        isOn.toggle()
        sender.setButtonBackGround(on: UIImage(systemName: "heart.fill")!, off: UIImage(systemName: "heart")!, onOffStatus: isOn)
        if let movie = movie {
            viewModel?.addRemoveMovieFromDB(isAdd: isOn, data: movie)
        }
    }
}

extension MovieDetailsViewController : MovieDetailsViewModelDelegate{
    func removeFromFavItmes(res: Bool) {
        self.navigationController?.popViewController(animated: true)
    }
}
