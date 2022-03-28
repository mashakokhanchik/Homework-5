//
//  ViewController.swift
//  Homework-5.1
//
//  Created by Мария Коханчик on 28.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var users = [UsersData]()

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCell")
        urlRequest()
    }

    func urlRequest() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "jsonplaceholder.typicode.com"
        urlComponents.path = "/users"
        
        guard let url = urlComponents.url else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                do {
                    self.users = try JSONDecoder().decode([UsersData].self, from: data!)
                } catch {
                    print("Parse error")
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }.resume()
    }

}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCollectionViewCell
        
        cell.nameLabel.text = users[indexPath.row].name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
}

