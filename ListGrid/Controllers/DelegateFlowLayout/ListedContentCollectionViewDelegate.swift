//
//  ListedContentCollectionViewDelegate.swift
//  ListGrid
//
//  Created by Admin on 13.05.2020.
//  Copyright © 2020 Mykola Korotun. All rights reserved.
//

import UIKit

class ListedContentCollectionViewDelegate: DefaultCollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left + sectionInsets.right
        let widthPerItem = collectionView.bounds.width - paddingSpace
        
        return CGSize(width: widthPerItem, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
