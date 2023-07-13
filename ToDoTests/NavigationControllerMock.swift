//
//  NavigationControllerMock.swift
//  ToDoTests
//
//  Created by Trevor  Keegan on 7/11/23.
//

import Foundation
import UIKit

class NavigationcontrollerMock: UINavigationController{
    var lastPushedViewController: UIViewController?
    var dismissed: Bool = false
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        lastPushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissed = true
        super.dismiss(animated: flag, completion: completion)
    }
}
