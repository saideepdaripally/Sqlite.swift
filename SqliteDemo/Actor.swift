//
//  Actor.swift
//  SqliteDemo
//
//  Created by Kvana Dev Ipod on 03/01/17.
//  Copyright © 2017 Kvana DevInc. All rights reserved.
//

import Foundation

class Actor{
    var  id : Int64?
    var name : String?
    var spouse : String?
    var country : String?
   
    /*
    var description : String?
    var dob : String?
    var height : String?
    var children : String?
    var image : String?
    */
    
    init(id: Int64) {
        self.id = id
        name = ""
        spouse = ""
        country = ""
      /*
        description = ""
        dob = ""
        height = ""
        children = ""
        image = ""  
       */
    }
    
init(id : Int64,name:String,country:String,spouse:String) {
         self.id = id
         self.name = name
         self.spouse = spouse
         self.country = country
      /*
         self.description = descrption
         self.dob = dob
         self.height = height
         self.children = children
         self.image = image   */
    }
}
