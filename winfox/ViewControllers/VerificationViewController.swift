//
//  VerificationViewController.swift
//  winfox
//
//  Created by muslim on 30.08.2021.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class VerificationViewController: UIViewController {
    
    //MARK: - Instants
    let authService = AuthService.shared
    
    //MARK: - Properties
    var countTimer:Timer!
    var counter = 10
    var code = ""
    var phoneNumber = ""
    
    
    //MARK: - Outlets
    @IBOutlet weak var tfOtp: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var resendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countTimer = Timer.scheduledTimer(timeInterval: 1 ,
                                                      target: self,
                                                      selector: #selector(self.changeTitle),
                                                      userInfo: nil,
                                                      repeats: true)
        hideKeyboard()
    }
    
    @IBAction func continueBtnAction(_ sender: Any) {
        authService.signIn(with: code, and: tfOtp.text!) { [weak self] result in
            switch result {
            case.success(let token):
                self?.showLoggedViewController()
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func showLoggedViewController() {
        let vc = LoggedViewController.loadFromStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func resendBtnAction(_ sender: Any) {
        
        authService.sendVerificationCode(to: phoneNumber) { result in
            switch result {
            case.success(let phoneNumber):
                print(phoneNumber)
            case.failure(let error):
                print(error)
            }
        }
    }
    
    @objc func changeTitle()
    {
         if counter != 0
         {
            resendButton.setTitle("Отправить смс через \(counter)", for: .normal)
            counter -= 1
         }
         else
         {
            resendButton.setTitle("Отправить смс повторно", for: .normal)
            resendButton.isEnabled = true
            countTimer.invalidate()
            resendButton.layer.cornerRadius = 12
            resendButton.backgroundColor = .systemBlue
         }
    }
}
