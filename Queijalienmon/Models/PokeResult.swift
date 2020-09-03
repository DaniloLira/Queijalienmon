//
//  PokeResult.swift
//  Queijalienmon
//
//  Created by Danilo Araújo on 02/09/20.
//  Copyright © 2020 mandabrasa. All rights reserved.
//

import Foundation
import UIKit
import PencilKit

class PokeResult {
    static var name: String? = nil
    static var image: UIImage? = nil
    static var draw: PKDrawing? = nil
    static var drawImage: UIImage? = nil
    
    static func clean(){
        PokeResult.name = nil
        PokeResult.image = nil
        PokeResult.draw = nil
        PokeResult.drawImage = nil
    }
}
