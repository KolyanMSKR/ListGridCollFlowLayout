//
//  PhotoCell.swift
//  ListGrid
//
//  Created by Admin on 09.05.2020.
//  Copyright © 2020 Mykola Korotun. All rights reserved.
//

import UIKit

class PeopleCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: PeopleCell.self)
    
    var imageStringURL: String? {
        didSet {
            if let stringURL = imageStringURL {
                peopleImageView.downloadImage(from: stringURL)
            }
        }
    }
    
    let peopleImageView: CacheImageView = {
        let imageView = CacheImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 750), for: .horizontal)
        imageView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 750), for: .vertical)
        
        return imageView
    }()
    
    let peopleName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        
        return label
    }()
    
    private let peopleStatusView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.masksToBounds = true
        
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 1
        
        backgroundColor = .white
        
        peopleImageView.addSubview(peopleStatusView)
        stackView.addArrangedSubview(peopleImageView)
        stackView.addArrangedSubview(peopleName)
        addSubview(stackView)
        
        let newConstraint = NSLayoutConstraint(item: peopleImageView, attribute: .width, relatedBy: .equal, toItem: peopleImageView, attribute: .height, multiplier: 1, constant: 0)
        peopleImageView.addConstraint(newConstraint)
        NSLayoutConstraint.activate([newConstraint])
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateContentStyle()
        peopleImageView.layer.cornerRadius = peopleImageView.bounds.width / 2
        peopleStatusView.layer.cornerRadius = peopleStatusView.bounds.width / 2
    }
    
    func update(title: String = "ASD", image: String) {
        //breedImageView.image = image
        peopleImageView.downloadImage(from: title)
        peopleName.text = title
    }
    
    private func updateContentStyle() {
        let isHorizontalStyle = bounds.width > 2 * bounds.height
        let oldAxis = stackView.axis
        let newAxis: NSLayoutConstraint.Axis = isHorizontalStyle ? .horizontal : .vertical
        guard oldAxis != newAxis else { return }

        stackView.axis = newAxis
        stackView.spacing = isHorizontalStyle ? 16 : 4
        peopleName.textAlignment = isHorizontalStyle ? .left : .center
        let fontTransform: CGAffineTransform = isHorizontalStyle ? .identity : CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.3) {
            self.peopleName.transform = fontTransform
            self.layoutIfNeeded()
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        let statusInset = CGFloat(sin(45 * Double.pi / 180)) - 6
        NSLayoutConstraint.activate([
            peopleStatusView.trailingAnchor.constraint(equalTo: peopleImageView.trailingAnchor, constant: statusInset),
            peopleStatusView.bottomAnchor.constraint(equalTo: peopleImageView.bottomAnchor, constant: statusInset),
            peopleStatusView.heightAnchor.constraint(equalToConstant: 8),
            peopleStatusView.widthAnchor.constraint(equalToConstant: 8)
        ])
    }
    
}
