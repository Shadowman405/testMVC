import Foundation

/// A utility that provides tools for processing email addresses and for extracting the company name
/// from the email domain.
enum EmailHandler {
    /// Extracts the company name from the domain of the given email address.
    ///
    /// - Parameter email: The email address to extract company name.
    /// - Returns: The company name extracted from the domain of the email address
    /// or `nil` if the email address is invalid.
    static func extractCompanyName(fromEmail email: String) -> String? {
        let isEmailValid = validateEmail(email)

        guard isEmailValid else { return nil }

        let atCharacter = "@"
        let dotCharacter = "."
        let emailComponents = email.components(separatedBy: atCharacter)
        let domainComponents = emailComponents.last?.components(separatedBy: dotCharacter)
        let numberOfComponentsInDomainPart = 2
        let domainName = domainComponents?.suffix(numberOfComponentsInDomainPart).first
        let companyName = verifiedCompanyName(basedOn: domainName)

        return companyName
    }

    /// Returns the company name based on the company's domain name.
    ///
    /// - Parameter domainName: The domain name of the company to be verified.
    /// - Returns: The company name, or `Unknown company` string
    /// if `nil` passed to `domainName` parameter.
    private static func verifiedCompanyName(basedOn domainName: String?) -> String? {
        guard let domainName else { return "Unknown company" }

        let companyNames = [
            "gmail": "Google",
            "exxonmobil": "Exxon Mobil",
            "att": "AT&T",
            "unitedhealthgroup": "UnitedHealth Group",
            "sinopec": "Sinopec Group",
            "cnpc": "China National Petroleum",
            "toyota": "Toyota Motor",
            "berkshirehathaway": "Berkshire Hathaway",
            "gm": "General Motors",
            "alphabet": "Alphabet (Google)",
        ]

        return companyNames[domainName] ?? domainName
    }

    /// Validates the given email address.
    ///
    /// - Parameter email: The email address to validate.
    /// - Returns: A Boolean value, `true` if the email addresses is valid, otherwise `false`.
    ///  If the verification was unsuccessful.
    static func validateEmail(_ email: String) -> Bool {
        let emailRegexPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegexPattern)

        return emailPredicate.evaluate(with: email)
    }
}
