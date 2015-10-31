# PasswordChecker
A general password checker

Usage example:
```swift
let passwordChecker = PasswordChecker()
passwordChecker.checkPw(password: "pA5$w0rd") {goodPassword, error in
    if goodPassword != nil {
        // update db or such
        print("Yay, the password was ok and now I can do something with it")
    } else {
        // use the error string for showing messages to the user
        print(error!)
    }
}
```
Check that the password is..
- ..not empty
- ..minimum 6 characters
- ..maximum 16 characters
- ..at least one uppercase character
- ..at least one lowercase character
- ..at least one number
- ..at least one character
- ..at least one special character
- ..without a whitespace
