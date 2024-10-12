//
//  ImageScrollerVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 19/09/22.
//

import UIKit

protocol ImageScrollerVCDelegate: AnyObject {
    //TODO: add in future
}
class ImageScrollerVC: UIViewController {
    
    @IBOutlet weak private var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak private var collectionView: UICollectionView!
    private var lastIndex: Int = 0
  
    private var contentList: [String] = []
    
    func configure(contentList: [String], indexClicked: Int) {
        self.contentList = contentList
        self.lastIndex = indexClicked
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAtTap))
        self.view.addGestureRecognizer(tapGesture)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = SnapToNearestCellLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        self.collectionView.decelerationRate = .fast
        registerCells()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        collectionView.scrollToItem(at: IndexPath(row: lastIndex, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    @objc private func dismissAtTap() {
        self.dismiss(animated: true)
    }
    
    private func registerCells() {
        collectionView.register(UINib(nibName: ImageScrollerCVC.identifier, bundle: .main), forCellWithReuseIdentifier: ImageScrollerCVC.identifier)
    }
}

extension ImageScrollerVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageScrollerCVC.identifier, for: indexPath) as? ImageScrollerCVC else {
            return UICollectionViewCell()
        }
        if let imageUrl = URL(string: contentList[indexPath.row]) {
            cell.configure(imgUrl: imageUrl)
        }
        return cell
    }
}

extension ImageScrollerVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionViewHeightConstraint.constant)
    }
}

extension ImageScrollerVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
