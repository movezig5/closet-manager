//
//  ClothingItem.swift
//  Closet Manager
//
//  Created by Daniel Ziegler on 3/13/16.
//  Copyright © 2016 CSC471. All rights reserved.
//

import UIKit

class ClothingItem: NSObject, NSCoding{
    
    struct PropertyKey {
        static let idKey = "id";
        static let nameKey = "name";
        static let typeKey = "type";
        static let sizeKey = "size";
        static let numSizeKey = "numSize";
        static let descriptionKey = "description";
        static let colorKey = "color";
        static let imageKey = "image";
    }
    
    enum Type: String{
        case Shirt = "Shirt"
        case Pants = "Pants"
        case Dress = "Dress"
        case Skirt = "Skirt"
        case Hat = "Hat"
        case Shoes = "Shoes"
        case Jacket = "Jacket"
        case Glove = "Glove"
        case Other = "Other"
    }
    
    var id: Int
    var name: String
    var type: Type
    var numSize: Int
    var size: String
    var desc: String
    var color: String
    var image: UIImage?
    
    init(id: Int, name: String, type: Type, color: String, numSize: Int, size: String, desc: String, image: UIImage?){
        self.id = id;
        self.name = name
        self.type = type
        self.color = color
        self.numSize = numSize
        self.size = size
        self.desc = desc
        if let picture = image {
            self.image = picture;
        }
        super.init();
    }
    
    override init(){
        self.id = -1;
        self.name = ""
        self.type = .Shirt
        self.color = "White"
        self.numSize = 0
        self.size = "M"
        self.desc = ""
        super.init();
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(id, forKey: PropertyKey.idKey);
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey);
        aCoder.encodeObject(type.rawValue, forKey: PropertyKey.typeKey);
        aCoder.encodeObject(size, forKey: PropertyKey.sizeKey);
        aCoder.encodeObject(numSize, forKey: PropertyKey.numSizeKey);
        aCoder.encodeObject(desc, forKey: PropertyKey.descriptionKey);
        aCoder.encodeObject(color, forKey: PropertyKey.colorKey);
        aCoder.encodeObject(image, forKey: PropertyKey.imageKey);
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObjectForKey(PropertyKey.idKey) as! Int;
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String;
        let numSize = aDecoder.decodeObjectForKey(PropertyKey.numSizeKey) as! Int;
        let size = aDecoder.decodeObjectForKey(PropertyKey.sizeKey) as! String;
        let color = aDecoder.decodeObjectForKey(PropertyKey.colorKey) as! String;
        let desc = aDecoder.decodeObjectForKey(PropertyKey.descriptionKey) as! String;
        let image = aDecoder.decodeObjectForKey(PropertyKey.imageKey) as? UIImage;
        let typeString = aDecoder.decodeObjectForKey(PropertyKey.typeKey) as! String;
        let type = Type(rawValue: typeString);
        self.init(id: id, name: name, type: type!, color: color, numSize: numSize, size: size, desc: desc, image: image);
    }
    // MARK: Archiving paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first;
    static let ArchiveURL = DocumentsDirectory!.URLByAppendingPathComponent("clothes");
}