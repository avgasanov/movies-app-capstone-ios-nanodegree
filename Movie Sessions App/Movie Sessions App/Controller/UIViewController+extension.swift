//
//  UIViewController+extension.swift
//  Movie Sessions App
//
//  Created by Abdulla Hasanov on 12/1/19.
//  Copyright © 2019 Abdulla Hasanov. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // from my on the map project for nanodegree
    func showAlertVC(errorMessage: String, completion: ((UIAlertAction) -> Void)?) {
        let errorAlertController = UIAlertController(title: "Error ocurred", message: errorMessage, preferredStyle: .alert)
        errorAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler:  completion))
        self.navigationController?.present(errorAlertController, animated: true, completion: nil)
    }
}
