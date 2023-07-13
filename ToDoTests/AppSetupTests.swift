//
//  AppSetupTests.swift
//  ToDoTests
//
//  Created by Trevor  Keegan on 7/10/23.
//

import Foundation
import XCTest
import UIKit
@testable import ToDo

class AppSetupTests: XCTestCase{
    func test_application_shouldSetupRoot() throws {
        let application = UIApplication.shared
        let scene = application.connectedScenes.first as? UIWindowScene
        let root = scene?.windows.first?.rootViewController
        let nav = try XCTUnwrap(root as? UINavigationController)
        XCTAssert(nav.topViewController is ToDoItemListViewController)
    }
}
