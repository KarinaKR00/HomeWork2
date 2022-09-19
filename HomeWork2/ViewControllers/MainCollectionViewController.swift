//
//  MainCollectionViewController.swift
//  HomeWork2
//
//  Created by Карина on 18.09.2022.
//

import UIKit



enum Link: String {
    case imageURL = "https://yesno.wtf/assets/no/27-8befe9bcaeb66f865dd3ecdcf8821f51.gif"
    case jokeURL = "https://geek-jokes.sameerkumar.website/api?format=json"
    case jokeTwoURL = "https://official-joke-api.appspot.com/random_joke"
}

enum UserAction: String, CaseIterable {
    case randomImage = "Random Image"
    case randomJoke = "Random Joke"
    case randomJokeTwo = "Random Joke Two"
}

class MainCollectionViewController: UICollectionViewController {
    
    private let userAction = UserAction.allCases

    override func viewDidLoad() {
        super.viewDidLoad()

       
       
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userAction.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        as? UserActionCell else { return UICollectionViewCell() }
    
        let userAction = userAction[indexPath.item]
        cell.userActionLabel.text = userAction.rawValue
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userAction[indexPath.item]
        
        switch userAction {
        
        case .randomImage: performSegue(withIdentifier: "CellOne", sender: nil)
        case .randomJoke: fetchJoke()
        case .randomJokeTwo: fetchJokeTwo()
        }
    }

    
    // MARK: - Private Method
    
    private func successAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Success",
                message: "You can see the results in the Debug aria",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func failedAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Failed",
                message: "You can see error in the Debug aria",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
 

}

extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}

// MARK: - Networking

extension MainCollectionViewController {
    private func fetchJoke() {
        
        guard let url = URL(string: Link.jokeURL.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let joke = try jsonDecoder.decode(Joke.self, from: data)
                self.successAlert()
                print(joke.joke)
            } catch {
                print(error.localizedDescription)
                self.failedAlert()
            }
            
        }.resume()
        
    }
    
    private func fetchJokeTwo() {
       guard let url = URL(string: Link.jokeTwoURL.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let jsonDecode = JSONDecoder()
            
            
            do {
                let joke = try jsonDecode.decode(JokeTwo.self, from: data)
                self.successAlert()
                print(joke.setup)
            } catch {
                print(error.localizedDescription)
                self.failedAlert()
            }
        }.resume()
        
    }
    
    
}

