import Foundation

class ValidationError: Error {
    var message: ValidateMessage
    
    init(_ message: ValidateMessage) {
        self.message = message
    }
}

enum ValidateMessage: String {
    case emptyUserName = "Username is Required"
    case shortUserName = "Username must contain more than 6 characters"
    case longUserName = "Username shouldn't contain more than 18 characters"
    case invalidUserName = "Invalid username, username should not contain numbers or special characters"
    
    case emptyPassword = "Password is Required"
    case shortPassword = "Password must contain more than 6 characters"
    case longPassword = "Password shouldn't contain more than 18 characters"
    case invalidPassword = "Password must be more than 6 characters, with at least one character and one numeric character"
    
    case invalidPhoneNumber = "Invalid phone number"
    
    case invalidEmail = "Invalid e-mail Address"
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
    
    static let userNameRegex = "^[a-zA-Z ]{1,18}$"
    static let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
    static let phoneRegex = "^[\\+]?[(]?[0-9]{3}[)]?[-\\s\\.]?[0-9]{3}[-\\s\\.]?[0-9]{4,6}$"
    static let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
    
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
        if value.isEmpty {
            return ValidationError(.emptyUserName)
        }
        
        if value.count <= 6 {
            return ValidationError(.shortUserName)
        }
        
        if value.count > 18 {
            return ValidationError(.longUserName)
        }
        
        let regex = try! NSRegularExpression(pattern: ValidatorFactory.userNameRegex,  options: .caseInsensitive)
        
        if regex.firstMatch(in: value, range: NSRange(location: 0, length: value.count)) != nil {
            return nil
        }
        
        return ValidationError(.invalidUserName)
    }
}

struct PasswordValidator: ValidatorConvertible {
    func validated(_ value: String) -> ValidationError? {
        if value.isEmpty {
            return ValidationError(.emptyPassword)
        }
        if value.count <= 6 {
            return ValidationError(.shortPassword)
        }
        
        if value.count > 18 {
            return ValidationError(.shortPassword)
        }
        
        let regex = try! NSRegularExpression(pattern: ValidatorFactory.passwordRegex,  options: .caseInsensitive)
        
        if regex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
            return ValidationError(.invalidPassword)
        }
        
        return nil
        
    }
}

struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String) -> ValidationError? {
        
        let regex = try! NSRegularExpression(pattern: ValidatorFactory.emailRegex, options: .caseInsensitive)
        
        let range = NSRange(location: 0, length: value.count)
        
        if regex.firstMatch(in: value, options: [], range: range) == nil {
            return ValidationError(.invalidEmail)
        }
        
        return nil
        
    }
}

struct PhoneValidator: ValidatorConvertible {
    func validated(_ value: String) -> ValidationError? {
        
        let regex = try! NSRegularExpression(pattern: ValidatorFactory.phoneRegex, options: .caseInsensitive)
        
        if regex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
            return ValidationError(.invalidPhoneNumber)
        }
        
        return nil
    }
}
