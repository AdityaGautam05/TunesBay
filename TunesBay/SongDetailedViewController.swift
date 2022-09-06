//
//  SongDetailedViewController.swift
//  Songs App
//
//  Created by Aditya Gautam on 05/05/21.
//

import UIKit
import NetworkManager
import AudioManager
import DatabaseManager

class SongDetailedViewController: UIViewController {
    
    let tableView = UITableView()
    var trackID : Int = 0
    var viewModel : DetailedPageViewModel
    let loader : UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .medium)
        loader.style = .large
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    let saveSongData = UIButton(type: .system)
    var barButton = UIBarButtonItem()
    var song = Song()
    var isSongFavourite : Bool = false
    
    init(ID: Int) {
        self.trackID = ID
        viewModel = DetailedPageViewModel(ID: trackID)
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupView()
        setupLoader()
        setupSaveDataButton()
        setupViewModel()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.viewWillDisappear()
    }
    
    private func setupViewModel(){
        viewModel.viewDidLoad()
    }
    
    private func setupSaveDataButton(){
        saveSongData.heightAnchor.constraint(equalToConstant: 30).isActive=true
        saveSongData.widthAnchor.constraint(equalToConstant: 30).isActive=true
        saveSongData.addTarget(self, action: #selector(addSongDataToDB), for: .touchUpInside)
        barButton = UIBarButtonItem(customView: saveSongData)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func addSongDataToDB(){
        if viewModel.isSongDetailedDataPresentInDB(trackId: trackID) == true {
            if DBHelper.shared.removeSongDetailedFromDB(StructData: song) == true {
                saveSongData.setImage(UIImage(named: "Upload-Icon-Transparent"), for: .normal)
            }
        }
        else {
            if viewModel.addSongDetailedDataToDB(song: song) == true {
                print("Song Data added to the database")
                saveSongData.setImage(UIImage(named: "Check-Icon-Transparent"), for: .normal)
            }
        }
    }
    
    private func setupLoader(){
        view.addSubview(loader)
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupView(){
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.contentInset = UIEdgeInsets(top: -47.0, left: 0.0, bottom: UIScreen.main.bounds.width, right: 0.0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.self.description())
        tableView.register(AlbumArtCell.self, forCellReuseIdentifier: AlbumArtCell.self.description())
        tableView.register(TitleSubtitleTableViewCell.self, forCellReuseIdentifier: TitleSubtitleTableViewCell.self.description())
        tableView.separatorStyle = .none
    }
    
    private func dismissLoader(){
        loader.stopAnimating()
    }
    
    private func showNavigationBar(){
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func hideNavigationBar(){
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension SongDetailedViewController: SongsDetailedAPIResponseDelegate {
    
    func showLoader() {
        loader.startAnimating()
    }
    
    func setTickIcon() {
        saveSongData.setImage(UIImage(named: "Check-Icon-Transparent"), for: .normal)
        print("Song Data Found")
    }
    
    func setUploadIcon(){
        saveSongData.setImage(UIImage(named: "Upload-Icon-Transparent"), for: .normal)
    }
    
    func trackPreviewDownloaded(Status: DownloadFileStatus) {
        if Status == .successful {
            let indexPath = IndexPath(row: 0, section: 0)
            guard let cell = tableView.cellForRow(at: indexPath) as? AlbumArtCell else { return }
            cell.spinner.stopAnimating()
            cell.mediaControlButton.isHidden = false
            switch AudioManager.shared.status {
            case .idle:
                cell.setPlayButton()
            case .paused:
                cell.setPlayButton()
            case .playing:
                cell.setPauseButton()
            }
        }
    }
    
    func didFinishGatheringDetailedSongAPIResponse(result: Song) {
        DispatchQueue.main.async {
            self.song = result
            self.tableView.reloadData()
            self.navigationItem.title = self.song.trackName
            self.setupSaveDataButton()
            self.dismissLoader()
        }
    }
}

extension SongDetailedViewController: UITableViewDelegate {
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell tapped at", indexPath.row)
    }
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        if song.trackName == "" {
            return 0
        } else {
            return 2
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 295 {
            showNavigationBar()
        } else {
            hideNavigationBar()
        }
    }
    
}

extension SongDetailedViewController: UITableViewDataSource {
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        } else {
            return 10
        }
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0, let artworkURL = song.artworkUrl100 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumArtCell.self.description(), for: indexPath) as? AlbumArtCell else { return UITableViewCell() }
            cell.setURLData(urlString: artworkURL)
            cell.delegate = self
            if song.isStreamable == true {
                setupMediaControlButton(cell: cell)
            }
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleSubtitleTableViewCell.self.description(), for: indexPath) as? TitleSubtitleTableViewCell else { return UITableViewCell() }
            if indexPath.row == 0, let trackName = song.trackName {
                cell.setTitleSubtitleData(Title: "Track Name", SubTitle: trackName)
            } else if indexPath.row == 1, let artistID = song.artistId {
                cell.setTitleSubtitleData(Title: "Artist ID", SubTitle: String(artistID))
            } else if indexPath.row == 2, let artistName = song.artistName {
                cell.setTitleSubtitleData(Title: "Artist Name", SubTitle: artistName)
            } else if indexPath.row == 3, let collectionName = song.collectionName {
                cell.setTitleSubtitleData(Title: "Album Name", SubTitle: collectionName)
            } else if indexPath.row == 4, let explicitness = song.collectionExplicitness {
                cell.setTitleSubtitleData(Title: "Explicitness", SubTitle: explicitness)
            } else if indexPath.row == 5, let collectionPrice = song.collectionPrice {
                cell.setTitleSubtitleData(Title: "Collection Price", SubTitle: String(collectionPrice))
            } else if indexPath.row == 6, let trackPrice = song.trackPrice {
                cell.setTitleSubtitleData(Title: "Track Price", SubTitle: String(trackPrice))
            } else if indexPath.row == 7, let releaseDate = song.releaseDate {
                cell.setTitleSubtitleData(Title: "Release Date", SubTitle: releaseDate)
            } else if indexPath.row == 8 ,let genre = song.primaryGenreName {
                cell.setTitleSubtitleData(Title: "Genre", SubTitle: genre)
            } else if indexPath.row == 9 ,let country = song.country {
                cell.setTitleSubtitleData(Title: "Country", SubTitle: country)
            }
            return cell
        }
        return UITableViewCell()
    }
}

extension SongDetailedViewController: AlbumArtcellDelegate {
    
    func setupMediaControlButton(cell : AlbumArtCell) {
        if song.isStreamable == true {
            cell.mediaControlButton.addTarget(self, action: #selector(playPauseButtonClicked), for: .touchUpInside)
        } else {
            cell.mediaControlButton.setImage(nil, for: .normal)
            return
        }
    }
    
    @objc func playPauseButtonClicked(){
        
        let indexPath = IndexPath(row: 0, section: 0)
        guard let cell = tableView.cellForRow(at: indexPath) as? AlbumArtCell else { return }
        
        if viewModel.downloadingStatus == DownloadFileStatus.none {
            viewModel.downloadTrackPreview(trackURL: song.previewUrl)
            cell.mediaControlButton.isHidden = true
            cell.spinner.startAnimating()
        }
        
        if viewModel.downloadingStatus == .successful {
            
            switch AudioManager.shared.status {
            case .idle:
                AudioManager.shared.playFromStart(track: song.previewUrl)
                cell.setPauseButton()
                cell.enableSlider()
                cell.slider.maximumValue = Float(AudioManager.shared.audioPlayer?.duration ?? 0)
                cell.slider.value = 0.0
                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            case .playing:
                AudioManager.shared.pause()
                cell.setPlayButton()
            case .paused:
                AudioManager.shared.play()
                cell.setPauseButton()
            }
        }
    }
    
    @objc func updateTime(_ timer : Timer) {
        let indexPath = IndexPath(row: 0, section: 0)
        guard let cell = tableView.cellForRow(at: indexPath) as? AlbumArtCell else { return }
        if cell.slider.value == Float(AudioManager.shared.audioPlayer?.currentTime ?? 0) {
            cell.setPlayButton()
            AudioManager.shared.status = .idle
        }
        cell.slider.value = Float(AudioManager.shared.audioPlayer?.currentTime ?? 0)
    }
}
