//
//  tableViewCell.swift
//  Songs App
//
//  Created by Aditya Gautam on 05/05/21.
//

import UIKit

extension UIImageView {
    func load(urlString : String) {
        guard let url = URL(string: urlString) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

public class SongHomepageCell: UITableViewCell {
    
    let artworkImage = UIImage()
    let title = UILabel()
    let subtitle = UILabel()
    var albumURL = String()
    let imageViewArtwork = UIImageView()
    let favouriteButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(imageViewArtwork)
        imageViewArtwork.translatesAutoresizingMaskIntoConstraints = false
        imageViewArtwork.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive=true
        imageViewArtwork.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10).isActive=true
        imageViewArtwork.widthAnchor.constraint(equalToConstant: 60).isActive=true
        imageViewArtwork.heightAnchor.constraint(equalToConstant: 60).isActive=true
        imageViewArtwork.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive=true
        imageViewArtwork.layer.cornerRadius = 30.0
        imageViewArtwork.layer.masksToBounds = true
        
        title.numberOfLines = 0
        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leadingAnchor.constraint(equalTo: imageViewArtwork.leadingAnchor, constant: 80).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        title.font = UIFont(name: "Roboto-Medium", size: 18)
        
        contentView.addSubview(favouriteButton)
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        favouriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive=true
        favouriteButton.topAnchor.constraint(equalTo: title.topAnchor, constant: 10).isActive=true
        //favouriteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive=true
        favouriteButton.heightAnchor.constraint(equalToConstant: 20).isActive=true
        favouriteButton.widthAnchor.constraint(equalToConstant: 20).isActive=true
        //favouriteButton.setImage(UIImage(named: "star-selected"), for: .normal)
        
        subtitle.numberOfLines = 1
        contentView.addSubview(subtitle)
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
        subtitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        subtitle.topAnchor.constraint(equalTo: title.lastBaselineAnchor, constant: 8).isActive=true
        //subtitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive=true
        subtitle.font = UIFont(name: "Roboto-Regular", size: 12)
        
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            contentView.backgroundColor = UIColor.white
        } else {
            contentView.backgroundColor = UIColor.white
        }
    }
    
    func configureCellData(song : Song){
        if song.isEmpty == false, let artworkURL = song.artworkUrl60 {
            title.text = song.trackName
            subtitle.text = song.collectionName
            albumURL = artworkURL
            setImageURL(URLData: albumURL)
        }
    }
    
    public func setImageURL(URLData : String){
        imageViewArtwork.load(urlString: URLData)
    }
    
    func setSelectedFavouriteIcon(){
        favouriteButton.setImage(UIImage(named: "star-selected"), for: .normal)
    }
    
    func setUnselectedFavouriteIcon(){
        favouriteButton.setImage(UIImage(named: "star-unselected"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
