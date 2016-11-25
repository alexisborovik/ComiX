//
//  ComixViewController.swift
//  ComiX
//
//  Created by Alexis on 11/21/16.
//  Copyright © 2016 Alexis. All rights reserved.
//

import UIKit
import RealmSwift


class ComixViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var comixName    : UITextField!
    var cover        : UIImageView!
    var getImageButt : UIButton!
    let imagePicker  = UIImagePickerController()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        view.backgroundColor = UIColor.darkGray
        addTextField()
        addGetImageButton()
        addCovetIV()
        addSaveButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        comixName.resignFirstResponder()
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            cover.image = pickedImage
            cover.contentMode = UIViewContentMode.scaleAspectFill
        }
        dismiss(animated: true, completion: nil)
    }
}

fileprivate extension ComixViewController {
    
    func addTextField(){
        comixName = UITextField()
        comixName.text = "New comics"
        comixName.delegate = self
        view.addSubview(comixName)
        comixName.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(view.snp.top).offset(70)
            make.width.equalTo(view.snp.width).inset(40)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(30)
        }
        comixName.backgroundColor = UIColor.blue
    }
    
    func addGetImageButton() {
        getImageButt = UIButton()
        getImageButt.addTarget(self, action: #selector(ComixViewController.getImage), for: .touchUpInside)
        view.addSubview(getImageButt)
        getImageButt.setTitle("Add new cover", for: .normal)
        getImageButt.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(comixName.snp.bottom).offset(20)
            make.width.equalTo(view.snp.width).inset(60)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(30)
        }
        getImageButt.backgroundColor = UIColor.green
    }
    
    func addCovetIV() {
        cover = UIImageView()
        cover.image = UIImage(named: "NewComics")
        view.addSubview(cover)
        cover.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(getImageButt.snp.bottom).offset(20)
            make.width.equalTo(view.snp.width).inset(10)
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).inset(10)
        }
        cover.backgroundColor = UIColor.yellow
    }
    
    func addSaveButton(){
        let saveButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ComixViewController.saveComix))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func getImage() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func saveComix() {
        let newComix = Comix()
        newComix.title = comixName.text!
        newComix.cover = Storage.common.saveImage(image: cover.image!)
        Storage.common.addNewComix(comix: newComix)
    }
}
