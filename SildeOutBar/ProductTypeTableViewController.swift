//
//  ProductTypeTableViewController.swift
//  SildeOutBar
//
//  Created by Keshav Raj on 27/06/18.
//  Copyright © 2018 Keshav Raj. All rights reserved.
//

import UIKit

protocol ProductTypeTableViewControllerDelegate:class {
    func ProductTypeTableViewController(didSelectRow row: Int)
}

class ProductTypeTableViewController: UITableViewController {
    weak var delegate:ProductTypeTableViewControllerDelegate?
    let cellReuseIdentifier = "productTypeCell"
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ProductTypes.count
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = ProductTypes[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.ProductTypeTableViewController(didSelectRow: indexPath.row)
    }

}
