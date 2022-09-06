//
//  titleSubtitleTableViewCell.swift
//  Songs App
//
//  Created by Aditya Gautam on 05/05/21.
//

import UIKit

class TitleSubtitleTableViewCell: UITableViewCell {
    
    let title = UILabel()
    let subtitle = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        title.numberOfLines = 0
        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10).isActive = true
        title.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10).isActive = true
        title.font = UIFont(name: "Roboto-Regular", size: 18)
        
        subtitle.numberOfLines = 0
        contentView.addSubview(subtitle)
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
        subtitle.trailingAnchor.constraint(equalTo: title.trailingAnchor).isActive = true
        subtitle.topAnchor.constraint(equalTo: title.topAnchor, constant: 22.5).isActive=true
        subtitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive=true
        subtitle.font = UIFont(name: "Roboto-Light", size: 12)
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            contentView.backgroundColor = UIColor.white
        } else {
            contentView.backgroundColor = UIColor.white
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setTitleSubtitleData(Title:String, SubTitle:String){
        title.text = Title
        subtitle.text = SubTitle
    }
    
}
