//: PasswordChecker
//  The password has to be:
//  x   not empty
//  x   minimum 6 characters
//  x   maximum 16 characters
//      at least one capital letter
//      at least one non-capital letter
//      at least one number
//      at least one character
//      Bonus:
//      at least one special character

import Foundation

// The possible error types for password
enum PasswordFail: ErrorType {
    case MinimumLength
    case MaximumLength
    case Empty
    case Uppercase
}

class PasswordChecker {
    // Check the password
    func checkPw(password pw: String, closure: (goodPassword: String?, error: String?)->()){
        // Test the pw and possibly throw a bunch of errors
        var goodPassword: String?
        var err: String?
        do {
            let _ = try readPw(pw)
            goodPassword = pw
        } catch PasswordFail.Empty {
            err = "You cannot insert an empty password."
        } catch PasswordFail.MinimumLength {
            err = "Your password does not meet the minimum character requirement of 6."
        } catch PasswordFail.MaximumLength {
            err = "Your password does not meet the maximum character requirement of 16."
        } catch PasswordFail.Uppercase {
            err = "Your password has no uppercase characters."
        } catch {
            err = "Unknown error!"
        }
        closure(goodPassword: goodPassword, error: err)
    }
    
    // The actual checker with a bunch of rules
    // Use guard for early return
    func readPw(pw: String) throws {
        guard pw.characters.count != 0 else {
            throw PasswordFail.Empty
        }
        guard pw.characters.count >= 6 else {
            throw PasswordFail.MinimumLength
        }
        guard pw.characters.count <= 16 else {
            throw PasswordFail.MaximumLength
        }
        guard pw.lowercaseString != pw else {
            throw PasswordFail.Uppercase
        }
    }
}

let passwordChecker = PasswordChecker()
passwordChecker.checkPw(password: "m123215M") {goodPassword, error in
    if goodPassword != nil {
        print("Yay, the password was ok and now I can do something with it")
    } else {
        print(error!)
    }
}


