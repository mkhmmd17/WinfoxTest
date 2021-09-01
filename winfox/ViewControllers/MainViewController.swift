//
//  Created by muslim on 30.08.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    let authService = AuthService.shared
    
    //MARK: - Outlets
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var getButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboard()
        tfPhone.delegate = self
    }
    
    //MARK: - Actions
    @IBAction func getCodeButtonTapped(_ sender: Any) {
        authService.sendVerificationCode(to: tfPhone.text ?? "") { [weak self] result in
            switch result {
            case.success(let code):
                self?.showVerificationVC(code: code)
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func showVerificationVC(code: String) {
        let vc = VerificationViewController.loadFromStoryboard()
        vc.code = code
        vc.phoneNumber = tfPhone.text!
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func isValidPhone(_ phone: String) -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{11,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let number = textField.text else { return }
        if isValidPhone(number) {
            getButton.isEnabled = true
            getButton.backgroundColor = .systemBlue
        } else {
            getButton.isEnabled = false
            getButton.backgroundColor = .systemGray2
        }
    }
}


