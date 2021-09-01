//
//  Created by muslim on 30.08.2021.
//

import UIKit
import FirebaseAuth

class AuthService {
    
    static let shared = AuthService()
    private let provider = PhoneAuthProvider.provider()
    private init() {}
    
    func sendVerificationCode(to number: String, completion: @escaping (Result<String, AuthError>) -> Void) {
        Auth.auth().settings?.isAppVerificationDisabledForTesting = false
        provider.verifyPhoneNumber(number, uiDelegate: nil) { verificationID, error in
            guard error == nil else {
                completion(.failure(.unableToConnect))
                return
            }
            
            guard let verificationId = verificationID else {
                completion(.failure(.unableToGetCorrectVerificationID))
                return
            }
            
            completion(.success(verificationId))
        }
    }
    
    func signIn(with verificationID: String, and code: String, completion: @escaping (Result<String, AuthError>) -> Void) {
        let credential = provider.credential(withVerificationID: verificationID, verificationCode: code)
        Auth.auth().signIn(with: credential) { authDataResult, error in
            guard error == nil else {
                completion(.failure(.unableToSignIn))
                return
            }
            
            guard let phoneNumber = authDataResult?.user.phoneNumber else {
                completion(.failure(.unableToGetCorrectPhoneNumber))
                return
            }
            
            completion(.success(phoneNumber))
        }
    }
}
