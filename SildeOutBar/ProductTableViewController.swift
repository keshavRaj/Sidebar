//
//  ProductTableViewController.swift
//  SildeOutBar
//
//  Created by Keshav Raj on 27/06/18.
//  Copyright © 2018 Keshav Raj. All rights reserved.
//

import UIKit

protocol ProductTableViewControllerDelegate: class {
    func barButtonTapped()
}

class ProductTableViewController: UITableViewController {
    
    var productDicArr: [[String: String]]!
    let cellReuseIdentifier = "productTableViewCell"
    weak var delegate:ProductTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ProductTableViewController -> ViewDidLoad")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productDicArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let productDicHere = productDicArr[indexPath.row]
        cell.textLabel?.text = productDicHere[ProductNameKey]
        cell.detailTextLabel?.text = productDicHere[ProductPriceKey]
        return cell
    }
    
    @IBAction func barButtonTapped(_ sender: UIBarButtonItem) {
        delegate?.barButtonTapped()
    }
    
}
