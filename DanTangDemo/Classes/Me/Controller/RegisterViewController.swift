//
//  RegisterViewController.swift
//  DanTangDemo
//
//

import UIKit

class RegisterViewController: BaseViewController {

    @IBOutlet weak var mobileField: UITextField!
    
    @IBOutlet weak var vertifyButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mobileField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
