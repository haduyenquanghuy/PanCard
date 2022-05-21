import Foundation

class ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) -> ValidationError?
}

enum ValidatorType {
    case email
    case password
    case username
    case phoneNumber
}

enum ValidatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email: return EmailValidator()
        case .password: return PasswordValidator()
        case .username: return UserNameValidator()
        case .phoneNumber: return PhoneValidator()
        }
    }
}


struct UserNameValidator: ValidatorConvertible {
    func validated(_ value: String)  -> ValidationError? {
        guard value.count >= 3 else {
            return ValidationError("Username must contain more than three characters" )
        }
        
        guard value.count < 18 else {
            return ValidationError("Username shouldn't contain more than 18 characters" )
        }
        
        let regex = try! NSRegularExpression(pattern: "^[a-z]{1,18}$",  options: .caseInsensitive)
        
        if regex.firstMatch(in: value, range: NSRange(location: 0, length: value.count)) != nil {
            return nil
        }
        
        return ValidationError("Invalid username, username should not contain whitespaces, numbers or special characters")
    }
}


struct PasswordValidator: ValidatorConvertible {
    func validated(_ value: String) -> ValidationError? {
        guard value != "" else {
            return ValidationError("Password is Required")
        }
        guard value.count >= 6 else {
            return ValidationError("Password must have at least 6 characters")
        }
        
        let regex = try! NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$",  options: .caseInsensitive)
        
        if regex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
            return ValidationError("Password must be more than 6 characters, with at least one character and one numeric character")
        }
        
        return nil
        
    }
}

//ValidationError("Invalid e-mail Address")

struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String) -> ValidationError? {
        
        let regex = try! NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive)
        
        let range = NSRange(location: 0, length: value.count)
        
        if regex.firstMatch(in: value, options: [], range: range) == nil {
            return ValidationError("Invalid e-mail Address")
        }
        
        return nil
        
    }
}

struct PhoneValidator: ValidatorConvertible {
    func validated(_ value: String) -> ValidationError? {
        
        let regex = try! NSRegularExpression(pattern: "^[\\+]?[(]?[0-9]{3}[)]?[-\\s\\.]?[0-9]{3}[-\\s\\.]?[0-9]{4,6}$", options: .caseInsensitive)
        
        if regex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
            return ValidationError("Invalid phone number")
        }
        
        return nil
    }
}
