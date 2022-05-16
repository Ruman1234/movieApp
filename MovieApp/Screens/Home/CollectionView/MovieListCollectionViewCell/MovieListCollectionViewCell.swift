//
//  MovieListCollectionViewCell.swift
//  MovieApp
//
//  Created by Ruman on 13/05/2022.
//

import UIKit
protocol MovieListCollectionViewCellDelegate{
    func addRemoveMovieFromDB(isAdd:Bool,index: Int)
}
class MovieListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnAddToFav: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    private var isOn: Bool = false
    private var data : MovieResultsArray?
    var delegate : MovieListCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func setupCell(data :MovieResultsArray){
        self.data = data
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.borderColor = UIColor.white.cgColor
        self.contentView.layer.borderWidth = 0.75
        
        self.lblTitle.text = data.title
        self.lblDate.text = data.release_date
        if let url = URL(string: "https://image.tmdb.org/t/p/w92\(data.poster_path ?? "")"){
            posterImg.load(url: url)
        }
        btnAddToFav.setButtonBackGround(on: UIImage(systemName: "heart.fill")!, off: UIImage(systemName: "heart")!, onOffStatus: data.favorite ?? false)
        isOn = data.favorite ?? false
    }
    
    @IBAction func btnFavPressed(_ sender: UIButton) {
        isOn.toggle()
        sender.setButtonBackGround(on: UIImage(systemName: "heart.fill")!, off: UIImage(systemName: "heart")!, onOffStatus: isOn)
        self.delegate?.addRemoveMovieFromDB(isAdd: isOn, index: self.tag)
    }
    
}
