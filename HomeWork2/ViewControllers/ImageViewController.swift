//
//  ViewController.swift
//  HomeWork2
//
//  Created by Карина on 18.09.2022.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }

    private func fetchImage() {
        guard let url = URL(string: Link.imageURL.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            print(response)
            
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = image
                
            }
            
            
        }.resume()
    }

}

