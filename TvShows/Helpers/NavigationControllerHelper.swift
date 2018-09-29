//
//  NavigationControllerHelper.swift
//  TvShows
//
//  Created by Bojan Petkovic on 29/09/2018.
//

import Foundation
import UIKit

class NavigationControllerHelper {
    class func setTransparentHeaders(navigationController: UINavigationController) {
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
    }
}
