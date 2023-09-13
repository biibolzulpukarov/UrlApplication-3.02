//
//  PricesViewController.swift
//  UrlApplication 3.02
//
//  Created by Бийбол Зулпукаров on 13/9/23.
//

import UIKit

enum Alert {
    case success
    case failed
    
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .failed:
            return "Failed"
        }
    }
    
    var message: String {
        switch self {
        case .success:
            return "You can see the results in the Debug area"
        case .failed:
            return "You can see error in the Debug area"
        }
    }
}

final class PricesViewController: UITableViewController {
    
    private var prices: [Price] = []
    
    let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        fetchPrices()
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        prices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let cell = cell as? PriceCell else { return UITableViewCell() }
        let price = prices[indexPath.row]
        cell.configure(with: price)
        return cell
    }
    
    
    // MARK: - Private Functions
    private func showAlert(withStatus status: Alert) {
        let alert = UIAlertController(title: status.title, message: status.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        DispatchQueue.main.async { [unowned self] in
            present(alert, animated: true)
        }
    }
}
    
    
// MARK: - Networking
extension PricesViewController {
    func fetchPrices() {
        networkManager.fetch([Price].self, from: Link.price.rawValue) { [weak self] result in
            switch result {
            case .success(let prices):
                self?.prices = prices
                self?.tableView.reloadData()
                print(prices)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}







    

    



