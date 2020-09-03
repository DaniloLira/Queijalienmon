//
//  ResultViewController.swift
//  Queijalienmon
//
//  Created by Danilo Araújo on 01/09/20.
//  Copyright © 2020 mandabrasa. All rights reserved.
//

import Foundation
import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var drawImageView: UIImageView!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.messageLabel.text = "Parabéns! O seu \(PokeResult.name ?? "") obteve o grau Rick chapado de Queijo Coalho! Você é um grande desenhista, seu pokelover!"
        self.drawImageView.image = PokeResult.drawImage
        self.pokeImageView.image = PokeResult.image

    }
    
    @IBAction func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
