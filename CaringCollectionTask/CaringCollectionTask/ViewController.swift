//
//  ViewController.swift
//  CaringCollectionTask
//
//  Created by Andrii's Macbook  on 27.09.2023.
//

import UIKit

final class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    var items: [String] = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = SnapPagingFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 500)
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 150, width: view.bounds.width, height: view.bounds.height - 150), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        let label = UILabel()
        label.frame = CGRect(x: 16, y: 100, width: view.bounds.width, height: 50)
        label.textAlignment = .left
        label.text = "Collection"
        label.font = UIFont.boldSystemFont(ofSize: 34)
        view.addSubview(label)
        view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemGray
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: collectionView.layoutMargins.left, bottom: 0, right: collectionView.layoutMargins.right)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = collectionView.collectionViewLayout as? SnapPagingFlowLayout else { return }
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        offset.x = roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left
        targetContentOffset.pointee = offset
    }
}

final class SnapPagingFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        minimumLineSpacing = 10
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
