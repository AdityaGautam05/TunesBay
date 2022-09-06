//
//  HomePageViewController.swift
//  Songs App
//
//  Created by Aditya Gautam on 22/05/21.
//

import UIKit
import NetworkManager

class HomePageViewController: UIViewController {
    
    var searchButton = UIButton()
    var barButton = UIBarButtonItem()
    var songsList : [Song] = []
    var favouriteSongs : [Int] = []
    let tableView = UITableView()
    var viewModel = HomePageViewModel()
    var favouriteSongsDetailedList : [Song] = []
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewDidLoad()
        favouriteSongs = []
        favouriteSongsDetailedList = []
        populateFavouriteSongs()
        populateFavouriteSongsDetailedData()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureHeader()
        configureSearchButton()
        configureViewModel()
        configureTableView()
    }
    
    private func populateFavouriteSongsDetailedData(){
        for i in favouriteSongs {
            let viewmodel = DetailedPageViewModel(ID: i)
            viewmodel.delegate = self
            viewmodel.viewDidLoad()
        }
    }
    
    private func populateFavouriteSongs(){
        favouriteSongs = DBHelper.shared.requestFavouriteSongsFromDB()
    }
    
    private func configureTableView(){
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
        tableView.register(TitleSubtitleTableViewCell.self, forCellReuseIdentifier: TitleSubtitleTableViewCell.self.description())
        tableView.separatorStyle = .none
    }
    
    private func configureViewModel(){
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
    private func configureSearchButton(){
        searchButton.heightAnchor.constraint(equalToConstant: 20).isActive=true
        searchButton.widthAnchor.constraint(equalToConstant: 28).isActive=true
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        barButton = UIBarButtonItem(customView: searchButton)
        self.navigationItem.rightBarButtonItem = barButton
        searchButton.setImage(UIImage(named: "Search"), for: .normal)
    }
    
    private func configureView(){
        view.backgroundColor = .white
    }
    
    private func configureHeader(){
        self.navigationItem.title = "TunesBay"
    }
    
    @objc func searchButtonTapped(){
        //let navController = UINavigationController(rootViewController: SearchSongViewController())
        //navController.modalPresentationStyle = .currentContext
        //self.present(navController, animated: true, completion: nil)
        let vc = SearchSongViewController()
        navigationController?.pushViewController(vc, animated: true)
        tableView.reloadData()
    }
}

extension HomePageViewController : UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            if songsList.isEmpty == false {
                return songsList.count
            }
        } else if section == 2{
            return 1
        } else {
            if favouriteSongsDetailedList.count > 1 {
                return favouriteSongsDetailedList.count
            }
        }
        return 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Saved Songs"
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            return cell
        } else if indexPath.section == 1 {
            if songsList.isEmpty == false, let cell = tableView.dequeueReusableCell(withIdentifier: SongHomepageCell.self.description(), for: indexPath) as? SongHomepageCell {
                songsList[indexPath.row].isEmpty = false
                cell.configureCellData(song: (songsList[indexPath.row]))
                return cell
            }
        } else if indexPath.section == 2 {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Favourite Songs"
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            return cell
        } else if indexPath.section == 3 {
            if favouriteSongsDetailedList[indexPath.row].trackName != "" , let cell = tableView.dequeueReusableCell(withIdentifier: SongHomepageCell.self.description(), for: indexPath) as? SongHomepageCell {
                favouriteSongsDetailedList[indexPath.row].isEmpty = false
                cell.configureCellData(song: (favouriteSongsDetailedList[indexPath.row]))
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension HomePageViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.contentView.backgroundColor = UIColor.white
        }
        if indexPath.section == 1{
            if songsList[indexPath.row].trackId != 0 {
                let vc = SongDetailedViewController(ID: songsList[indexPath.row].trackId)
                navigationController?.pushViewController(vc, animated: true)
            }
        } else if indexPath.section == 3 {
            if favouriteSongsDetailedList[indexPath.row].trackId != 0 {
                let vc = SongDetailedViewController(ID: favouriteSongsDetailedList[indexPath.row].trackId)
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension HomePageViewController : SongsListAPIResponseDelegate {
    
    func didFinishGatheringSongsListAPIResponse(result: [Song]) {
        songsList = result
    }
}

extension HomePageViewController : SongsDetailedAPIResponseDelegate {
    
    func didFinishGatheringDetailedSongAPIResponse(result: Song) {
        var flag = 0
        for i in favouriteSongsDetailedList{
            if i.trackName == result.trackName{
                flag=1
                break
            }
        }
        
        if result.trackName != "" && flag==0 {
            favouriteSongsDetailedList.append(result)
        }
        tableView.reloadData()
    }
    
    func trackPreviewDownloaded(Status: DownloadFileStatus) {
        // Track Preview Downloaded
    }
    
    func setTickIcon() {
        // Tick Button Set
    }
    
    func showLoader() {
        // To Show Loader
    }
    
    func setUploadIcon() {
        // To Upload Icon
    }
}
