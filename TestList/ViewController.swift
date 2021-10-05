//
//  ViewController.swift
//  TestList
//
//  Created by Parth Sarathi on 7/12/21.
//

import UIKit

protocol ViewToViewModelDelegate {
    func fetchData()
    func numberofUsers() -> Int?
    func userAtIndex(index: Int) -> User?
}

class TableViewController: UITableViewController, ViewModelToViewDelegate {

    var viewModel: ViewModel? = ViewModel()
    
    func dataFetched() {
        self.tableView.reloadData()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel?.delegate = self
        viewModel?.fetchData()
        tableView.tableFooterView = UIView()
    }
    
    func showError(errorDescription: String) {
        let alert = UIAlertController(title: "Error", message: errorDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (alert: UIAlertAction) in}
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension TableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberofUsers() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserTableViewCell
        
        if let user = viewModel?.userAtIndex(index: indexPath.row) {
            cell.name.text = user.name
            cell.userName.text = user.username
            cell.city.text = user.address?.city
        }
        return cell 
    }
}
