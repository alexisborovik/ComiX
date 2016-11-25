//
//  Comix.swift
//  ComiX
//
//  Created by Alexis on 11/13/16.
//  Copyright © 2016 Alexis. All rights reserved.
//

import RealmSwift

public class Comix : Object {
    
    dynamic var title = ""
    dynamic var cover = ""

    var pages = List<Page>()

}
