//
//  DetailPeopleViewController.swift
//  ListGrid
//
//  Created by Admin on 13.05.2020.
//  Copyright © 2020 Mykola Korotun. All rights reserved.
//

import UIKit

class DetailPeopleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view1 = DetailPeopleView(name: "asd", status: false, email: "@@@")
        self.view = view1
    }
    
}

class DetailPeopleView: UIView {
    
    let nameLabel = UILabel()
    let statusLabel = UILabel()
    let emailButton = UIButton(title: "email")
    
    let profileImageView: CacheImageView = {
        let imageView = CacheImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    init(name: String, status: Bool, email: String) {
        super.init(frame: UIScreen.main.bounds)
        
        setUI()
        nameLabel.text = name
        status ? (statusLabel.text = "Online") : (statusLabel.text = "Offline")
        emailButton.setTitle(email, for: .normal)
        
        profileImageView.downloadImage(from: "https://d3pbdh1dmixop.cloudfront.net/assets/readdle/desktop/index/internship2020/intern-photos/photo5.png?1588259920")
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -60),
            emailButton.widthAnchor.constraint(equalToConstant: 150),
            emailButton.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        emailButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(statusLabel)
        addSubview(emailButton)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            statusLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 60)
        ])
        
        NSLayoutConstraint.activate([
            emailButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emailButton.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor, constant: 60),
            emailButton.widthAnchor.constraint(equalToConstant: 200),
            emailButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
