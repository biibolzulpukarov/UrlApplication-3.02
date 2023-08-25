//
//  ViewController.swift
//  UrlApplication 3.02
//
//  Created by Бийбол Зулпукаров on 24/8/23.
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


final class ViewController: UIViewController {

    @IBAction func showDataButtonPressed() {
        showData()
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
    
    private func showData() {
        guard let url = URL(string: "https://api.nbp.pl/api/cenyzlota/last/30/?format=json#") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let prices = try decoder.decode([Price].self, from: data)
                print(prices)
                self?.showAlert(withStatus: .success)
            } catch let error {
                print(error.localizedDescription)
                self?.showAlert(withStatus: .failed)
            }
            
        }.resume()
    }
}

