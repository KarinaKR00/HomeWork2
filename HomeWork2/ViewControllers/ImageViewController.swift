//
//  ViewController.swift
//  HomeWork2
//
//  Created by Карина on 18.09.2022.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }

    private func fetchImage() {
        NetworkManager.shared.fetchImage(from: Link.imageURL.rawValue) {[weak self] result in
            switch result {
            case .success(let imageData):
                self?.imageView.image = UIImage(data: imageData)
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }

}

