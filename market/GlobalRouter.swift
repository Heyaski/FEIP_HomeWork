//
//  GlobalRouter.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-05.
//

import UIKit

final class GlobalRouter {
    
    static let instance = GlobalRouter()
    
    weak var window: UIWindow?
    
    private init() {}
 
    func setMain() {
        let mainVC = ProductViewController()
            
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
    }
}
