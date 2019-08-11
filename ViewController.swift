//
//  ViewController.swift
//  Tag
//
//  Created by Apple on 10/08/19.
//  Copyright © 2019 Revolut. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var inputContainerView: UIView!
    @IBOutlet weak var inputContainerViewBottom: NSLayoutConstraint!
    @IBOutlet weak var growingTextView: NextGrowingTextView!
    @IBOutlet var toolbarview: UIView!
    @IBOutlet weak var tagView: UIView!
    
    // MARK: Tagging Button Declaration
    let firstButton:UIButton = UIButton()
    let secondButton:UIButton = UIButton()
    var exclusionPathFirst:UIBezierPath = UIBezierPath()
    var exclusionPathSecond:UIBezierPath = UIBezierPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.growingTextView.layer.cornerRadius = 4
        self.growingTextView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        self.growingTextView.placeholderAttributedText = NSAttributedString(
            string: "Placeholder text",
            attributes: [
                .font: self.growingTextView.textView.font!,
                .foregroundColor: UIColor.gray,
            ]
        )
        growingTextView.textView.inputAccessoryView = toolbarview
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Validate Userdefault Values - First Viewcontroller
        if(UserDefaults.standard.object(forKey: "first") != nil) {
            self.FirstTag(title: UserDefaults.standard.object(forKey: "first") as! String)
        } else {
            print("nothing first tags")
        }
        
        // Validate Userdefault Values - Second Viewcontroller
        if(UserDefaults.standard.object(forKey: "second") != nil) {
            self.SecondTag(title: UserDefaults.standard.object(forKey: "second") as! String)
        } else {
            print("nothing second tags")
        }
    }
    
    func FirstTag(title:String){
        
        growingTextView.textView.insertText("#\(title) ")
        //growingTextView.textView.resolveTags()
        self.resolveTags()

        /*// Add First Tag Button
        firstButton.setImage(UIImage(named: "calendar"), for: .normal)
        firstButton.setTitle(" \(title)", for: .normal)
        firstButton.titleLabel?.font = firstButton.titleLabel?.font.withSize(15)
        firstButton.titleLabel?.numberOfLines = 0
        firstButton.titleLabel?.adjustsFontSizeToFitWidth = true
        firstButton.backgroundColor =  #colorLiteral(red: 0.1503946781, green: 0.5074903369, blue: 0.9339994788, alpha: 1)
        firstButton.tintColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        firstButton.sizeToFit()
        firstButton.layer.cornerRadius = 4
        firstButton.layer.borderWidth = 1
        firstButton.layer.borderColor = #colorLiteral(red: 0.1503946781, green: 0.5074903369, blue: 0.9339994788, alpha: 1)
        
        /*let attributedWithTextColor: NSAttributedString = growingTextView.textView.text.attributedStringWithColor(["\(title)"], color: UIColor.red)
        growingTextView.textView.attributedText = attributedWithTextColor*/
        
        /*firstButton.frame = CGRect(x: 3, y: 3, width: firstButton.frame.width + 15, height: firstButton.frame.height + 5)
        //let size = CGSize(width: firstButton.frame.width + 15, height: firstButton.frame.height + 5)
        //let cursorPosition = growingTextView.textView.caretRect(for: growingTextView.textView.selectedTextRange!.end).origin
        //firstButton.frame = CGRect(origin: cursorPosition, size: size)
        firstButton.addTarget(self, action: #selector(firstbuttonAction), for: .touchUpInside)
        growingTextView.addSubview(firstButton)
        
        let exclusionPathFirst:UIBezierPath = UIBezierPath(rect: CGRect(x: 3, y: 3, width: firstButton.frame.size.width, height: firstButton.frame.size.height))
        growingTextView.textView.textContainer.exclusionPaths  = [exclusionPathFirst]
        growingTextView.addSubview(firstButton)*/
        
        let size = CGSize(width: firstButton.frame.width + 15, height: firstButton.frame.height + 5)
        let cursorPosition = growingTextView.textView.caretRect(for: growingTextView.textView.selectedTextRange!.start).origin
        firstButton.frame = CGRect(origin: cursorPosition, size: size)
        firstButton.addTarget(self, action: #selector(firstbuttonAction), for: .touchUpInside)
        
        //let exclusionPathSecond:UIBezierPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: secondButton.frame.size.width, height: secondButton.frame.size.height))
        let sizes = CGSize(width: firstButton.frame.width, height: firstButton.frame.height)
        exclusionPathFirst = UIBezierPath(rect: CGRect(origin: cursorPosition, size: sizes))
        growingTextView.textView.textContainer.exclusionPaths  = [exclusionPathFirst]
        //growingTextView.addSubview(firstButton)*/
        
        // Before Remove - Restore first value to another Key
        //UserDefaults.standard.removeObject(forKey: "first")
    }
    
    func SecondTag(title:String){
        
        growingTextView.textView.insertText("#\(title) ")
        self.resolveTags()

        // Add Second Tag Button
        /*secondButton.setImage(UIImage(named: "calendar"), for: .normal)
        secondButton.setTitle(" \(title)", for: .normal)
        secondButton.titleLabel?.font = secondButton.titleLabel?.font.withSize(15)
        secondButton.titleLabel?.numberOfLines = 0
        secondButton.titleLabel?.adjustsFontSizeToFitWidth = true
        secondButton.backgroundColor =  #colorLiteral(red: 0.1503946781, green: 0.5074903369, blue: 0.9339994788, alpha: 1)
        secondButton.tintColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        secondButton.sizeToFit()
        secondButton.layer.cornerRadius = 4
        secondButton.layer.borderWidth = 1
        secondButton.layer.borderColor = #colorLiteral(red: 0.1503946781, green: 0.5074903369, blue: 0.9339994788, alpha: 1)

        //secondButton.frame = CGRect(x: 3, y: 3, width: secondButton.frame.width + 15, height: secondButton.frame.height + 5)
        //let position = CGPoint(x: 0, y: 3)
        let size = CGSize(width: secondButton.frame.width + 15, height: secondButton.frame.height + 5)
        let cursorPosition = growingTextView.textView.caretRect(for: growingTextView.textView.selectedTextRange!.start).origin
        secondButton.frame = CGRect(origin: cursorPosition, size: size)
        secondButton.addTarget(self, action: #selector(secondbuttonAction), for: .touchUpInside)
        
        //let exclusionPathSecond:UIBezierPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: secondButton.frame.size.width, height: secondButton.frame.size.height))
        let sizes = CGSize(width: secondButton.frame.width, height: secondButton.frame.height)
        exclusionPathSecond = UIBezierPath(rect: CGRect(origin: cursorPosition, size: sizes))
        growingTextView.textView.textContainer.exclusionPaths  = [exclusionPathSecond]
        growingTextView.addSubview(secondButton) */
        
        // Before Remove - Restore first value to another Key
        //UserDefaults.standard.removeObject(forKey: "second")
    }
    
    // MARK: Tag Buttons Action
    @objc func firstbuttonAction(sender: UIButton!) {
        // Before Remove Button - Remove Userdefault Stored Value Properly
        
        //firstButton.isHidden = true
        //firstButton.removeFromSuperview()
        exclusionPathFirst.removeAllPoints()
        self.setNeedsFocusUpdate()
    }
    
    @objc func secondbuttonAction(sender: UIButton!) {
        // Before Remove Button - Remove Userdefault Stored Value Properly
       
        //secondButton.isHidden = true
        //secondButton.removeFromSuperview()
        exclusionPathSecond.removeAllPoints()
        self.setNeedsFocusUpdate()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @objc func keyboardWillHide(_ sender: Notification) {
        if let userInfo = (sender as NSNotification).userInfo {
            if let _ = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
                self.inputContainerViewBottom.constant =  0
                UIView.animate(withDuration: 0.25, animations: { () -> Void in self.view.layoutIfNeeded() })
            }
        }
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        if let userInfo = (sender as NSNotification).userInfo {
            if let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
                self.inputContainerViewBottom.constant = keyboardHeight
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
                
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Detected")
    }

    
    /*func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        // empty text means backspace
        if text.isEmpty {
            textView.attributedText.enumerateAttribute(NSAttributedString.Key.attachment, in: NSMakeRange(0, textView.attributedText.length), options: NSAttributedString.EnumerationOptions(rawValue: 0)) { [weak self] (object, imageRange, stop) in
                
                if NSEqualRanges(range, imageRange) {
                    self?.attributedText.replaceCharactersInRange(imageRange, withString: "")
                }
            }
        }
        return true
    }*/
    
    func resolveTags(){
        let nsText:NSString = self.growingTextView.textView.text as NSString
        let words:[String] = nsText.components(separatedBy: " ")
        
        let attrs = [
            NSAttributedString.Key.font : UIFont.init(name: "HelveticaNeue", size: 15),
            NSAttributedString.Key.foregroundColor : UIColor.black
            
        ]
        
        let attrString = NSMutableAttributedString(string: nsText as String, attributes:attrs as [NSAttributedString.Key : Any])
        
        for word in words {
            if word.hasPrefix("#") {
                let matchRange:NSRange = nsText.range(of: word as String)
                var stringifiedWord:String = word as String
                stringifiedWord = String(stringifiedWord.dropFirst())
                attrString.addAttribute(NSAttributedString.Key.link, value: "hash:\(stringifiedWord)", range: matchRange)
                //attrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black , range: matchRange)
                //attrString.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.red , range: matchRange)
            }
        }
        self.growingTextView.textView.attributedText = attrString
        UserDefaults.standard.removeObject(forKey: "first")
        UserDefaults.standard.removeObject(forKey: "second")
    }
}

/*extension UITextView {
    func resolveTags(){
        let nsText:NSString = self.text as NSString
        let words:[String] = nsText.components(separatedBy: " ")
        
        let attrs = [
            NSAttributedString.Key.font : UIFont.init(name: "HelveticaNeue", size: 15),
            NSAttributedString.Key.foregroundColor : UIColor.black
            
        ]
        
        let attrString = NSMutableAttributedString(string: nsText as String, attributes:attrs as [NSAttributedString.Key : Any])
        
        for word in words {
            if word.hasPrefix("#") {
                let matchRange:NSRange = nsText.range(of: word as String)
                var stringifiedWord:String = word as String
                stringifiedWord = String(stringifiedWord.dropFirst())
                //attrString.addAttribute(NSAttributedString.Key.link, value: "hash:\(stringifiedWord)", range: matchRange)
                //attrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black , range: matchRange)
                //attrString.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.red , range: matchRange)
                
                let label:UILabel = UILabel()
                label.text = "My Label"
                textView.addSubview(label)
            }
        }
        self.attributedText = attrString
    }
}*/

// 1. Get Current cursor Range and assing to UIButton X position
// 2. Delete the UIButton from UITextView using backspace

// Examples
// https://github.com/smozgur/UIButton-inside-UITextView
// https://github.com/rickytan/RTViewAttachment
// https://github.com/popodidi/HTagView
// https://stackoverflow.com/questions/28424045/combining-text-and-images-in-uitextview/36790608

