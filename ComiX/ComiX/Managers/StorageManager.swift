//
//  StorageManager.swift
//  ComiX
//
//  Created by Alexis on 11/12/16.
//  Copyright © 2016 Alexis. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class Storage{
    
    public static let common    = Storage()
    
    public var comixList        : Results<Comix>
    public let realm            : Realm
    public let documentsDirPath : String
    
    public init() {
        realm = try! Realm()
        documentsDirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        comixList = realm.objects(Comix.self)
    }
    
    public func addNewComix(comix : Comix){
        try! realm.write {
            realm.add(comix)
        }
    }
    
    public func deleteComix(comix : Comix){
        try! realm.write {
            realm.delete(comix)
        }
    }
    
    public func swapPages(first : Int, second : Int, in comicsIndex : Int){
        try! realm.write {
            comixList[comicsIndex].pages.swap(index1: first, second)
        }
    }
    
    public func saveImage(image : UIImage)->String{
        let imageName = Tools.getUniqueString()
        let photoURL = NSURL(fileURLWithPath: documentsDirPath).appendingPathComponent(imageName)
        let data = UIImagePNGRepresentation(image)
        try! data?.write(to: photoURL!, options: Data.WritingOptions.atomic)
        return imageName
    }
    
    public func loadImage(imageName: String) -> UIImage? {
        var image = UIImage()
        let photoURL = NSURL(fileURLWithPath: documentsDirPath).appendingPathComponent(imageName)
        let data = try? Data (contentsOf: photoURL!)
        if data != nil {
            image = UIImage(data:data!)!
        } 
        return image
    }
    
}

