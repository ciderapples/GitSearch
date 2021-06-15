//
//  StoryboardInstantiatable.swift
//  GitSearch
//
//  Created by Jacky Lao on 6/15/21.
//

import UIKit

protocol StoryboardInstantiatable: AnyObject {
    static var storyboard: UIStoryboard { get }
    static var identifier: String { get }
}

extension StoryboardInstantiatable where Self: UIViewController {
    
    static var storyboard: UIStoryboard {
        UIStoryboard(name: String(describing: self), bundle: .main)
    }
    
    static var identifier: String {
        String(describing: self)
    }
    
    static func instantiate<ViewController>(
        storyboard: UIStoryboard = storyboard, identifier: String = identifier, creator: ((NSCoder) -> ViewController?)? = nil
    ) -> Self where ViewController : UIViewController {
        storyboard.instantiateViewController(identifier: identifier, creator: creator) as! Self
    }
}
