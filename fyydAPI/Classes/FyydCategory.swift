//
//  FyydCategory.swift
//  Podcat 2
//
//  Created by Jeanette Müller on 06.04.17.
//  Copyright © 2017 Jeanette Müller. All rights reserved.
//

import Foundation

public class FyydCategory{
    public let identifier:Int
    public let slug:String
    public let image:String
    public let name:String
    public init(identifier id:Int, andSlug slug:String, andName name:String, andImage image:String){
        
        self.identifier = id
        self.slug = slug
        self.image = image
        self.name = name
    }
}
