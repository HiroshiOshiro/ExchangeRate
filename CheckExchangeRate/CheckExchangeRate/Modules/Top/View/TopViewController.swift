//
//  TopViewController.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/02.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {
    
    var presenter: TopPresentation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
}


extension TopViewController: TopView {
    func showResult() {
        
    }
    
    func setCurrency() {
        
    }
    
    func exchangeCurrency() {
        
    }
    
 
}
