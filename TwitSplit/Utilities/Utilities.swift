//
//  Utilities.swift
//  TwitSplit
//
//  Created by nhatlee on 3/1/18.
//  Copyright © 2018 nhatlee. All rights reserved.
//

import Foundation
import UIKit
typealias ConfirmCallback = (Bool) -> Void

class Utilities {
    static func showMessageAt(_ VC: UIViewController, title: String, message: String, confirmTitle: String, cancelTitle: String?, callback: @escaping ConfirmCallback) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
            callback(true)
        }
        alertVC.addAction(confirmAction)
        if let cancelTitle = cancelTitle {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
                callback(false)
            }
            alertVC.addAction(cancelAction)
        }
        VC.present(alertVC, animated: true, completion: nil)
    }
}
