//
//  ComixPageViewController.swift
//  ComiX
//
//  Created by Alexis on 11/12/16.
//  Copyright © 2016 Alexis. All rights reserved.
//

import UIKit

class PageListsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    var pagesCollectionView : UICollectionView!
    var segmentedControl    : UISegmentedControl!
    var pagePatternsMenu    : UIView!
    var pagePatternCV       : UICollectionView!
    var comixIndex          = -1
    var isEditingMode       = false
    var selectedPage        = -1
    var isPageMenuShowing   = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        addMainCollectionView()
        addSegmentedControl()
        addPagePatternsMenu()
        addToolBarButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pagesCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // if collectionView == pagesCollectionView {
        return Storage.common.comixList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == pagesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageListCollectionViewCell.cellIdentifier, for: indexPath) as! PageListCollectionViewCell
       
            cell.backgroundColor = UIColor.orange
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PagePatternsCollectionViewCell.cellIdentifier, for: indexPath) as! PagePatternsCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == pagesCollectionView {
            if isEditingMode {
                selectedPage = indexPath.item
                pagesCollectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.green
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == pagesCollectionView {
            if isEditingMode {
                deselect(selected: indexPath.item)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("moove")
    }
    
    func deselect(selected: Int){
        pagesCollectionView.cellForItem(at: IndexPath(item: selected, section: 0))?.backgroundColor = UIColor.orange
    }
    
    func handleLongGesture(_ gesture: UILongPressGestureRecognizer) {
        if isEditingMode {
        switch(gesture.state) {
            
        case UIGestureRecognizerState.began:
            guard let selectedIndexPath = self.pagesCollectionView.indexPathForItem(at: gesture.location(in: self.pagesCollectionView)) else {
                break
            }
            pagesCollectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case UIGestureRecognizerState.changed:
            pagesCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizerState.ended:
            pagesCollectionView.endInteractiveMovement()
        default:
            pagesCollectionView.cancelInteractiveMovement()
        }
        }
    }
    
    func addMainCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: 200, height: 290)
        pagesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        pagesCollectionView.dataSource = self
        pagesCollectionView.delegate = self
        pagesCollectionView.register(PageListCollectionViewCell.self, forCellWithReuseIdentifier: PageListCollectionViewCell.cellIdentifier)
        pagesCollectionView.backgroundColor = .white
        self.view.addSubview(pagesCollectionView)
        addLongPressGetsure()
    }
    
    func addLongPressGetsure(){
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(_:)))
        pagesCollectionView.addGestureRecognizer(longPressGesture)
    }
   
    func addSegmentedControl(){
        segmentedControl = UISegmentedControl(items: ["Read", "Edit"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(PageListsViewController.switchMode(_:)), for: .valueChanged)
        self.navigationItem.titleView = segmentedControl
    }
    
    func switchMode(_ sender:UISegmentedControl!){
        isEditingMode = !isEditingMode
        self.navigationController?.setToolbarHidden(!(self.navigationController?.isToolbarHidden)!, animated: true)
        if !isEditingMode {
            hidePatternsMenu()
            deselect(selected: selectedPage)
            selectedPage = -1
        }
    }
    
    func addPagePatternsMenu(){
        pagePatternsMenu = UIView(frame: CGRect(x: -300, y: 64, width: 250, height: view.bounds.height - 108))
        pagePatternsMenu.backgroundColor = UIColor.darkGray
        pagePatternsMenu.clipsToBounds = true
        view.addSubview(pagePatternsMenu)
        addPagePatternsCV()
    }
    
    func addPagePatternsCV(){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: 200, height: 290)
        pagePatternCV = UICollectionView(frame: CGRect(x: 0, y: 0, width: pagePatternsMenu.frame.width, height: pagePatternsMenu.frame.height)  , collectionViewLayout: layout)
        pagePatternCV.dataSource = self
        pagePatternCV.delegate = self
        pagePatternCV.register(PagePatternsCollectionViewCell.self, forCellWithReuseIdentifier: PagePatternsCollectionViewCell.cellIdentifier)
        pagePatternCV.backgroundColor = .yellow
        pagePatternsMenu.addSubview(pagePatternCV)
    }
    
    func showPatternsMenu(){
        UIView.animate(withDuration: 0.7, animations: {
            self.pagePatternsMenu.frame.origin.x = 0
        })
        isPageMenuShowing = !isPageMenuShowing
    }
    
    func hidePatternsMenu(){
        UIView.animate(withDuration: 0.7, animations: {
            self.pagePatternsMenu.frame.origin.x = -300
        })
        isPageMenuShowing = !isPageMenuShowing
    }
    
    func addToolBarButtons(){
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(PageListsViewController.addNewPage))
        toolbarItems = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),addButton]
    }
    
    @objc func addNewPage(){
        if isEditingMode {
            isPageMenuShowing ? hidePatternsMenu() : showPatternsMenu()
        }
    }
}


