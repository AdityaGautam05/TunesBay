//
//  SongListViewController.swift
//  Songs App
//
//  Created by Aditya Gautam on 03/05/21.
//

import UIKit

class SongListViewController : UIViewController {
    
    let tableView = UITableView()
    var viewModel : SongsListViewModel
    let loader : UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .medium)
        loader.style = .large
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    var songsList = [Song]()
    var artistName : String
    
    init(name : String){
        artistName = name
        viewModel = SongsListViewModel(name: artistName)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        viewModel =  SongsListViewModel(name: "Maroon+5")
        artistName = "Maroon+5"
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setupView()
        setupTableView()
        setupLoader()
        setupViewModel()
    }
    
    private func setupViewModel(){
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
    private func setupHeader(){
        self.navigationItem.title = "Songs"
    }
    
    private func setupLoader(){
        view.addSubview(loader)
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loader.startAnimating()
    }
    
    private func setupView(){
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
        tableView.register(SongHomepageCell.self, forCellReuseIdentifier: SongHomepageCell.self.description())
        tableView.separatorStyle = .none
    }
    
    private func dismissLoader(){
        loader.stopAnimating()
    }
}

extension SongListViewController : SongsListAPIResponseDelegate {
    
    internal func didFinishGatheringSongsListAPIResponse(result: [Song]) {
        self.songsList = result
        self.tableView.reloadData()
        self.dismissLoader()
    }
}

extension SongListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if songsList[indexPath.row].trackId != 0 {
            let vc = SongDetailedViewController(ID: songsList[indexPath.row].trackId)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension SongListViewController : UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if songsList.isEmpty == false {
            return songsList.count
        } else {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if songsList.isEmpty == false, let cell = tableView.dequeueReusableCell(withIdentifier: SongHomepageCell.self.description(), for: indexPath) as? SongHomepageCell {
            songsList[indexPath.row].isEmpty = false
            cell.configureCellData(song: (songsList[indexPath.row]))
            if viewModel.isSongFavourite(trackID: songsList[indexPath.row].trackId) == true {
                cell.setSelectedFavouriteIcon()
            } else {
                cell.setUnselectedFavouriteIcon()
            }
            setupFavouriteButton(cell: cell)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension SongListViewController : SongsListPageDelegate {
    func setupFavouriteButton(cell : SongHomepageCell) {
        cell.favouriteButton.addTarget(self, action: #selector(onTapFavouriteButton), for: .touchUpInside)
    }
    
    @objc func onTapFavouriteButton(_ sender: UIButton){
        let point = sender.convert(CGPoint.zero, to: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point) else { return }
        guard let cell = tableView.cellForRow(at: indexPath) as? SongHomepageCell else { return }
        if viewModel.isSongFavourite(trackID: songsList[indexPath.row].trackId) == true {
            if viewModel.removeFromFavouriteSongsList(trackID: songsList[indexPath.row].trackId) == true {
                cell.setUnselectedFavouriteIcon()
            }
        } else {
            if viewModel.addToFavouriteSongsList(trackID: songsList[indexPath.row].trackId) == true {
                cell.setSelectedFavouriteIcon()
            }
        }
        tableView.reloadData()
    }
}
