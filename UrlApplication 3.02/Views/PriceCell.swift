//
//  PriceCell.swift
//  UrlApplication 3.02
//
//  Created by Бийбол Зулпукаров on 13/9/23.
//

import UIKit

class PriceCell: UITableViewCell {

    @IBOutlet var dataLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
  
    func configure(with price: Price) {
        dataLabel.text = "Data: \(price.data)"
        priceLabel.text = "Price: \(price.cena)"
    }

}
