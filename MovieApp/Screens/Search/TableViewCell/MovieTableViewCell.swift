//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Ruman on 13/05/2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnFavMovie: UIButton!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var mainView: UIView!
    private var isOn: Bool = false
    private var data : MovieResultsArray?
    var delegate : MovieListCollectionViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupCell(data :MovieResultsArray){
        self.data = data
        self.mainView.layer.cornerRadius = 10
        self.mainView.layer.borderColor = UIColor.white.cgColor
        self.mainView.layer.borderWidth = 0.75
        
        self.lblTitle.text = data.title
        self.lblDate.text = data.release_date
        if let url = URL(string: "https://image.tmdb.org/t/p/w92\(data.poster_path ?? "")"){
            imgPoster.load(url: url)
        }
        btnFavMovie.setButtonBackGround(on: UIImage(systemName: "heart.fill")!, off: UIImage(systemName: "heart")!, onOffStatus: data.favorite ?? false)
        isOn = data.favorite ?? false
    }
    
    @IBAction func btnFavMoviePresssedd(_ sender: UIButton) {
        isOn.toggle()
        sender.setButtonBackGround(on: UIImage(systemName: "heart.fill")!, off: UIImage(systemName: "heart")!, onOffStatus: isOn)
        self.delegate?.addRemoveMovieFromDB(isAdd: isOn, index: self.tag)
    }
    
}
