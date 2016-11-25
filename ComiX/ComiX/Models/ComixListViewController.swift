//
//  ComixListViewController.swift
//  ComiX
//
//  Created by Alexis on 11/12/16.
//  Copyright © 2016 Alexis. All rights reserved.
//

import UIKit

class ComixListViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{

    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewComicsButt()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: 230, height: 320)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ComixListCollectionViewCell.self, forCellWithReuseIdentifier: ComixListCollectionViewCell.cellIdentifier)
        collectionView.backgroundColor = .white
        self.view.addSubview(collectionView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Storage.common.comixList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComixListCollectionViewCell.cellIdentifier, for: indexPath) as! ComixListCollectionViewCell
        cell.title.text = Storage.common.comixList[indexPath.item].title
        cell.cover.image = Storage.common.loadImage(imageName: Storage.common.comixList[indexPath.item].cover)
        cell.backgroundColor = UIColor.orange
        return cell
    }
    
    func addNewComicsButt(){
        let addButton = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ComixListViewController.toNewComics))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func toNewComics() {
        self.navigationController?.pushViewController(ComixViewController(), animated: true)
    }
}
