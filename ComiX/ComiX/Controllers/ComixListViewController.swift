//
//  ComixListViewController.swift
//  ComiX
//
//  Created by Alexis on 11/12/16.
//  Copyright © 2016 Alexis. All rights reserved.
//

import UIKit

class ComixListViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{

    var collectionView      : UICollectionView!
    var segmentedControl    : UISegmentedControl!
    
    var isEditingMode       = false
    var isToolBarHidden     = true
    var selectedComicsIndex = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addComixCollectionView()
        addSegmentedControl()
        addToolBarButtons()
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
        cell.backgroundColor = UIManager.cellColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEditingMode {
            selectedComicsIndex = indexPath.item
            collectionView.cellForItem(at: indexPath)?.backgroundColor = UIManager.selectedCellColor
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if isEditingMode {
            deselectCell(selected: indexPath.item)
        }
    }
 }

fileprivate extension ComixListViewController {
    
    func addComixCollectionView(){
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: getComixCollectionViewLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ComixListCollectionViewCell.self, forCellWithReuseIdentifier: ComixListCollectionViewCell.cellIdentifier)
        collectionView.backgroundColor = UIManager.collectionViewColor
        self.view.addSubview(collectionView)
    }
    
    func getComixCollectionViewLayout() -> UICollectionViewLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: 230, height: 320)
        return layout
    }
    
    func addSegmentedControl(){
        segmentedControl = UISegmentedControl(items: ["Read", "Edit"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(ComixListViewController.switchMode(_:)), for: .valueChanged)
        self.navigationItem.titleView = segmentedControl
    }
    
    @objc func switchMode(_ sender:UISegmentedControl!){
        isEditingMode = !isEditingMode
        self.navigationController?.setToolbarHidden(!(self.navigationController?.isToolbarHidden)!, animated: true)
        if !isEditingMode {
            deselectCell(selected: selectedComicsIndex)
            selectedComicsIndex = -1
        }
    }
    
    func addToolBarButtons(){
        toolbarItems =  [ getFlexibleButton(), getNewComicsButton() , getFlexibleButton(), getEditComicsButton(), getFlexibleButton(), getRemoveComicsButton(),  getFlexibleButton()]
    }
    
    func getNewComicsButton() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(ComixListViewController.addNewComics))
    }
    
    func getRemoveComicsButton() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.trash, target: self, action: #selector(ComixListViewController.removeComics))
    }
    
    func getEditComicsButton() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.edit, target: self, action: #selector(ComixListViewController.editComics))
    }
    
    func getFlexibleButton() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    }

    @objc func addNewComics(){
        if isEditingMode {
            print("addcomics")
        }
    }
    
    @objc func editComics(){
        if isEditingMode {
            print("editcomics")
        }
    }
    @objc func removeComics(){
        if isEditingMode {
            print("removecomics")
        }
    }
    
    func deselectCell(selected: Int){
        collectionView.cellForItem(at: IndexPath(item: selected, section: 0))?.backgroundColor = UIManager.cellColor
    }
}
