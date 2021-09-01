//
//  Created by muslim on 30.08.2021.
//

import Foundation

enum AuthError: String, Error {
    case unableToGetCorrectVerificationID = "Unable to get correct verification id, please wait we are working on this."
    case unableToSignIn = "Unable to sign in, please check the verification code, and try again"
    case unableToGetCorrectPhoneNumber = "Unable to get the correct number, please try again"
    case unableToConnect = "Unable to connect, please check your internet connection"
}
