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
    
    static let shared = PokeResult()
    var name: String? = nil
    var image: UIImage? = nil
    var draw: PKDrawing? = nil
    var drawImage: UIImage? = nil
}
