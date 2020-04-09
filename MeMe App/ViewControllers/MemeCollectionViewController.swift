//
//  MemeCollectionViewController.swift
//  MeMe App
//
//  Created by Gerardo Tarazona Caceres on 4/9/20.
//  Copyright © 2020 udacity. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyMemesLabel: UILabel!
    // MARK: - Properties
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var memes: [Meme] {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.memes ?? []
    }
    
    //MARK: - View Updates
    func showEmptyViewIfNeeded() {
        if memes.count > 0 {
            collectionView.isHidden = false
            emptyMemesLabel.isHidden = true
        } else {
            collectionView.isHidden = true
            emptyMemesLabel.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let uiNib = UINib(nibName: Constants.NibNames.memeCollectionCell, bundle: Bundle(for: MemeCollectionViewController.self))
        collectionView.register(uiNib, forCellWithReuseIdentifier: Constants.ReuseIdentifiers.memeCollectionCell)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let space:CGFloat = 3.0
        let dimension = (collectionView.frame.size.width - (2 * space) - 10) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        collectionView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        flowLayout.prepare()
        flowLayout.invalidateLayout()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showEmptyViewIfNeeded()
        collectionView.reloadData()
    }
}

extension MemeCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let meme = memes[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseIdentifiers.memeCollectionCell, for: indexPath) as? MemeCollectionViewCell
        cell?.set(image: meme.memedImage)
        return cell ?? UICollectionViewCell()
    }
    
    
}

extension MemeCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let detailMemeVC = storyboard?.instantiateViewController(withIdentifier: Constants.storyBoardsIdentifiers.detailMemeView) as? MemeDetailViewController else {
            return
        }
        detailMemeVC.meme = memes[indexPath.row]
        self.navigationController?.pushViewController(detailMemeVC, animated: true)
    }
}
