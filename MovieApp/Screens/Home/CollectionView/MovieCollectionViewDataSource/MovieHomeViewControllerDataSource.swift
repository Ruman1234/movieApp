//
//  MovieHomeViewControllerDataSource.swift
//  MovieApp
//
//  Created by Ruman on 13/05/2022.
//

import Foundation
import UIKit
protocol MovieViewControllerDelegate :AnyObject{
    func selectedCell(row: Int)
    func addRemoveMovieFromDB(isAdd:Bool,index: Int)
}

class MovieHomeViewControllerDataSource:NSObject, UICollectionViewDelegate, UICollectionViewDataSource{
    
    weak var delegate : MovieViewControllerDelegate?
    var movieArray : [MovieResultsArray]
    
    init(withDelegate delegate :MovieViewControllerDelegate, movieArray: [MovieResultsArray]) {
        self.movieArray = movieArray
        self.delegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = movieArray[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCollectionViewCellIdentifier, for: indexPath) as! MovieListCollectionViewCell
        cell.delegate = self
        cell.tag = indexPath.row
        cell.setupCell(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.selectedCell(row: indexPath.row)
    }
}

extension MovieHomeViewControllerDataSource :MovieListCollectionViewCellDelegate{
    func addRemoveMovieFromDB(isAdd: Bool, index: Int) {
        self.delegate?.addRemoveMovieFromDB(isAdd: isAdd, index: index)
    }
}

extension MovieHomeViewControllerDataSource : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
