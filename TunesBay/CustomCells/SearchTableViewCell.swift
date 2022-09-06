//
//  SearchTableViewCell.swift
//  Songs App
//
//  Created by Aditya Gautam on 22/05/21.
//

import UIKit
import DatabaseManager

class SearchTableViewCell: UITableViewCell {
    
    let textField = UITextField()
    let doneButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textField.placeholder = "Search artist here"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.search
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        contentView.addSubview(textField)
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive=true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive=true
        textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive=true
        textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive=true
        textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive=true
        
        contentView.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints=false
        doneButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40).isActive=true
        doneButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive=true
        doneButton.heightAnchor.constraint(equalToConstant: 30).isActive=true
        doneButton.widthAnchor.constraint(equalToConstant: 30).isActive=true
        //doneButton.setImage(UIImage(named: "Check-Icon-Transparent"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchTableViewCell : UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text == ""{
            doneButton.setImage(UIImage(),for: .normal)
        } else {
            doneButton.setImage(UIImage(named: "search-icon-transparent"), for: .normal)
        }
    }
}

