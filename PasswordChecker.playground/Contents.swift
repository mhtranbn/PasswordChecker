//: PasswordChecker
//  The password has to be:
//  x   not empty
//  x   minimum 6 characters
//  x   maximum 16 characters
//  x   at least one capital letter
//  x   at least one non-capital letter
//  x   at least one number
//  x   at least one character
//      Bonus:
//  x   at least one special character
//  x   without a whitespace

import Foundation

// Short-hand regex extension
extension NSRegularExpression {
    func generalTest(toBeTested str: String) -> NSTextCheckingResult? {
        let range = NSMakeRange(0, str.characters.count)
        return self.firstMatchInString(str, options: .WithTransparentBounds, range: range)
    }
}

// The possible error types for password
enum PasswordFail: ErrorType {
    case MinimumLength
    case MaximumLength
    case Empty
    case Uppercase
    case Lowercase
    case Number
    case Character
    case Special
    case WhiteSpace
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
            err = "Your password has to include at least one uppercase character."
        } catch PasswordFail.Lowercase {
            err = "Your password has to include at least one lowercase character."
        } catch PasswordFail.Number {
            err = "Your password has to include at least one numeric character."
        } catch PasswordFail.Character {
            err = "Your password has to include at least one word character."
        } catch PasswordFail.Special {
            err = "Your password has to include at least one special character."
        } catch PasswordFail.WhiteSpace {
            err = "Your password cannot include a whitespace, a tab space or a line break."
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
        guard pw.uppercaseString != pw else {
            throw PasswordFail.Lowercase
        }
        var regex = try! NSRegularExpression(pattern: "\\d", options: .CaseInsensitive)
        guard regex.generalTest(toBeTested: pw) != nil else {
            throw PasswordFail.Number
        }
        regex = try! NSRegularExpression(pattern: "[A-Za-z]", options: .CaseInsensitive)
        guard regex.generalTest(toBeTested: pw) != nil else {
            throw PasswordFail.Character
        }
        regex = try! NSRegularExpression(pattern: "[^\\w]", options: .CaseInsensitive)
        guard regex.generalTest(toBeTested: pw) != nil else {
            throw PasswordFail.Special
        }
        regex = try! NSRegularExpression(pattern: "[\\s]", options: .CaseInsensitive)
        guard regex.generalTest(toBeTested: pw) == nil else {
            throw PasswordFail.WhiteSpace
        }
    }
}

let passwordChecker = PasswordChecker()
passwordChecker.checkPw(password: "maaaa2M@") {goodPassword, error in
    if goodPassword != nil {
        print("Yay, the password was ok and now I can do something with it")
    } else {
        print(error!)
    }
}

let regex = try! NSRegularExpression(pattern:"[\\s]", options: .CaseInsensitive)
if regex.generalTest(toBeTested: "0101") != nil {
    print("gotcha")
}



