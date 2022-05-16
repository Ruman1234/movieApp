//
//  Extensions.swift
//  MovieApp
//
//  Created by Ruman on 13/05/2022.
//

import Foundation
import UIKit

extension UIViewController{
    func createAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.destructive, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
}

extension UIButton{
    func setButtonBackGround(on: UIImage, off: UIImage, onOffStatus: Bool ) {
        switch onOffStatus {
        case true:
            self.setImage(on, for: .normal)
        default:
            self.setImage(off, for: .normal)
        }
    }
}
fileprivate let cache = NSCache<NSString,UIImage>()
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let image = cache.object(forKey: url.absoluteString as NSString){
                DispatchQueue.main.async {
                    self?.image = image
                }
            }else if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cache.setObject(image, forKey: url.absoluteString as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }
}
