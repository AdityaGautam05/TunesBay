//
//  SearchSongViewController.swift
//  Songs App
//
//  Created by Aditya Gautam on 22/05/21.
//

import UIKit
import DatabaseManager

class SearchSongViewController : UIViewController {
    
    let tableView = UITableView()
    var artistName = String()
    var recentSearches = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        populateRecentSearches()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupTableView()
    }
    
    private func populateRecentSearches(){
        recentSearches = DBHelper.shared.retrieveRecentSearches(call: RecentSearchDatabaseRequest())
    }
    
    private func configureView(){
        view.backgroundColor = .white
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.self.description())
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.self.description())
        tableView.separatorStyle = .none
    }
}

extension SearchSongViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return recentSearches.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.self.description(), for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
            cell.doneButton.addTarget(SearchSongViewController(), action: #selector(search), for: .touchUpInside)
            return cell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = recentSearches[indexPath.row]
            cell.textLabel?.textColor = .gray
            return cell
        }
    }
    
    @objc func search(){
        let indexPath = IndexPath(row: 0, section: 0)
        guard let cell = tableView.cellForRow(at: indexPath) as? SearchTableViewCell else { return }
        guard let artist = cell.textField.text else { return }
        artistName = artist
        
        guard let navigationController = self.navigationController else { return }
        
        //        var navigationArray = navigationController.viewControllers
        //        navigationArray.remove(at: navigationArray.count - 1)
        //        self.navigationController?.viewControllers = navigationArray
        
        let status = DBHelper.shared.addRecentSearches(search: artist, call: RecentSearchDatabaseRequest())
        if status == true {
            print("Recent Search Added")
        }
        let vc = SongListViewController(name: artistName)
        navigationController.pushViewController(vc, animated: true)
    }
}

extension SearchSongViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = IndexPath(row: 0, section: 0)
        guard let searchcell = tableView.cellForRow(at: index) as? SearchTableViewCell else { return }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.contentView.backgroundColor = UIColor.white
            searchcell.textField.text = cell.textLabel?.text
        }
    }
}

