//
//  Extensions.swift
//  Assessment
//
//  Created by Torbit-iOS on 28/10/21.
//

import Foundation
import UIKit

//MARK:- UIViewController Extensions
extension UIViewController{
    //Simple Alert
    func showAlert(message : String){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // Alert with Action
    func showAlertwithAction(message : String?, completionHandler : @escaping ()-> Void ){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
                completionHandler()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK:- Activity Indicators Handling
    
    func startActivityIndicator(){
        DispatchQueue.main.async {
            let indicatorView = UIActivityIndicatorView(style: .large)
            indicatorView.frame = UIScreen.main.bounds
            indicatorView.color = .white
            indicatorView.startAnimating()
            indicatorView.tag = 54321
            self.view.addSubview(indicatorView)
            self.view.bringSubviewToFront(indicatorView)
        }
    }
    
    func stopActivityIndicator(){
        DispatchQueue.main.async {
            if let indicatorView = self.view.viewWithTag(54321) {
                indicatorView.removeFromSuperview()
            }
        }
    }
}


//MARK:- UIView Extensions

extension UIView{
    func addShadow(){
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 1, height: 5)
        self.layer.shadowRadius = 5
    }
}

//MARK:- String Extensions

extension String{
    public func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
