//
//  ViewController.swift
//  ActiveLabelDemo
//
//  Created by Johannes Schickling on 9/4/15.
//  Copyright © 2015 Optonaut. All rights reserved.
//

import UIKit
import ActiveLabel

class ViewController: UIViewController {
    
    @IBOutlet weak var label: ActiveLabel!
    
    let text = "This is a post with #multiple #hashtags and a @userhandle. Links are also supported like" +
    " this one: http://optonaut.co. Now it also supports custom patterns -> are\n\n" +
        "Let's trim a long link: \nhttps://twitter.com/twicket_app/status/649678392372121601"

    override func viewDidLoad() {
        super.viewDidLoad()
        label.textColor = UIColor.red
        label.canUpdateOnSelection = false
        label.enabledTypes = []
        
        let customTypes = ["#multiple", "@userhandle"].map { identifier in
            return ActiveType.range(identifier: identifier)
        }
        
        
        let nsString = text as NSString
        
        for type in customTypes {
            switch type {
            case .range(let identifier):
                let range = nsString.range(of: identifier)
                label.addCustomRange(range, for: type)
            default:
                break
            }
        }
        label.customize { label in
            label.text = self.text
            label.numberOfLines = 0
            label.lineSpacing = 4
            
            label.textColor = .red
//            label.hashtagColor = UIColor(red: 85.0/255, green: 172.0/255, blue: 238.0/255, alpha: 1)
//            label.mentionColor = UIColor(red: 238.0/255, green: 85.0/255, blue: 96.0/255, alpha: 1)
//            label.URLColor = UIColor(red: 85.0/255, green: 238.0/255, blue: 151.0/255, alpha: 1)
//            label.URLSelectedColor = UIColor(red: 82.0/255, green: 190.0/255, blue: 41.0/255, alpha: 1)

//            label.handleMentionTap { self.alert("Mention", message: $0) }
//            label.handleHashtagTap { self.alert("Hashtag", message: $0) }
//            label.handleURLTap { self.alert("URL", message: $0.absoluteString) }

            //Custom types
//            label.customColor[type] = UIColor.red
//            label.customSelectedColor[type] = UIColor.red
//            label.customColor[customType2] = UIColor.magenta
//            label.customSelectedColor[customType2] = UIColor.green
            
            label.configureLinkAttribute = { (type, attributes, isSelected) in
                var atts = attributes
                switch type {
                case .range:
                    atts[NSAttributedString.Key.font] = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.boldSystemFont(ofSize: 14)

//                case customType3:
//                    atts[NSAttributedString.Key.font] = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.boldSystemFont(ofSize: 14)
                default: ()
                }
                
                return atts
            }
            
            for type in customTypes {
                label.customColor[type] = UIColor.blue
                label.customSelectedColor[type] = UIColor.blue
                label.handleCustomTap(for: type) { self.alert("Custom type", message: $0) }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alert(_ title: String, message: String) {
        let vc = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        vc.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(vc, animated: true, completion: nil)
    }

}

