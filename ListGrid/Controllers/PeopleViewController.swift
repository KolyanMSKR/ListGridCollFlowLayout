//
//  ViewController.swift
//  ListGrid
//
//  Created by Admin on 08.05.2020.
//  Copyright © 2020 Mykola Korotun. All rights reserved.
//

import UIKit

fileprivate enum PresentationStyle: String, CaseIterable {
    case list
    case grid
    
    var buttonImage: UIImage {
        switch self {
        case .list: return #imageLiteral(resourceName: "default_grid")
        case .grid: return #imageLiteral(resourceName: "table")
        }
    }
}

class PeopleViewController: UIViewController {
    
    // MARK: - properties
    
    private let networkService = NetworkService()
    private var collectionView: UICollectionView!
    
    private var selectedStyle: PresentationStyle = .list {
        didSet {
            updatePresentationStyle()
        }
    }
    
    private var styleDelegates: [PresentationStyle: CollectionViewSelectableItemDelegate] = {
        let result: [PresentationStyle: CollectionViewSelectableItemDelegate] = [
            .list: ListedContentCollectionViewDelegate(),
            .grid: GriddedContentCollectionViewDelegate()
        ]
        
        return result
    }()
    
    private var images: [Image] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let presentationSegment: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["List", "Grid"])
        segmentedControl.sizeToFit()
        segmentedControl.selectedSegmentIndex = 0
        
        return segmentedControl
    }()
    
    private let simulateChangesButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Simulate changes", for: .normal)
        button.addTarget(self, action: #selector(simulateModelChanges), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func simulateModelChanges() {
        print("simulateModelChanges")
    }
    
    @objc private func segmentValueChanged() {
        switch presentationSegment.selectedSegmentIndex {
        case 0:
            selectedStyle = PresentationStyle.list
            print("List")
        case 1:
            selectedStyle = PresentationStyle.grid
            print("Grid")
        default:
            break
        }
    }
    
    // MARK: - Lifecycle's methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updatePresentationStyle()
        setUI()
        getJSONData()
        selectPeopleItem()
    }
    
    private func setUI() {
        presentationSegment.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        navigationItem.titleView = presentationSegment
        view.addSubview(simulateChangesButton)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: simulateChangesButton.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            simulateChangesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            simulateChangesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            simulateChangesButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            simulateChangesButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func updatePresentationStyle() {
        if let collectionView = collectionView {
            navigationItem.rightBarButtonItem?.image = selectedStyle.buttonImage
            
            collectionView.delegate = styleDelegates[selectedStyle]
            collectionView.performBatchUpdates({
                collectionView.reloadData()
            }, completion: nil)
        } else {
            setupCollectionView()
        }
    }
    
    private func selectPeopleItem() {
        styleDelegates.values.forEach {
            $0.didSelectItem = { indexPath in
                let detailViewController = DetailPeopleViewController()
                self.navigationController?.pushViewController(detailViewController, animated: true)
            }
        }
    }
    
    private func getJSONData() {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=100") else { return }
        let request = URLRequest(url: url)
        
        networkService.fetchJSONData(of: Image.self, request: request) { (response) in
            guard let response = response else {
                self.showAlert(title: "Error", message: "Data is not available!")
                return
            }
            
            for image in response {
                self.images.append(image)
            }
        }
    }
    
    private func setupCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = .zero
        view.addSubview(collectionView)
        collectionView.register(PeopleCell.self, forCellWithReuseIdentifier: PeopleCell.reuseIdentifier)
        self.collectionView = collectionView
        self.collectionView.dataSource = self
        
        updatePresentationStyle()
    }
    
}

// MARK: - UICollectionViewDataSource
extension PeopleViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PeopleCell.reuseIdentifier,
                                                      for: indexPath) as! PeopleCell
        
        cell.imageStringURL = images[indexPath.item].url
        
        
        //cell.peopleName.text = "ASD"
        
        
        return cell
    }
    
}
