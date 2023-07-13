//
//  ViewControllerMock.swift
//  ToDoTests
//
//  Created by Trevor  Keegan on 7/12/23.
//

import Foundation
import UIKit
class ViewControllerMock: UIViewController{
    var lastPresentedController: UIViewController?
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        lastPresentedController = viewControllerToPresent
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
