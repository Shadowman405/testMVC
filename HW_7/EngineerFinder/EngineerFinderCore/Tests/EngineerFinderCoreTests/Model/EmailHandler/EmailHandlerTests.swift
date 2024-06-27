@testable import EngineerFinderCore
import XCTest

final class EmailHandlerTests: XCTestCase {
    func test_extractCompanyName_fromEmailsWithouSubDomain_returnsCompanyName() {
        // Given
        let emailsWithSimpleDomains = [
            "klareton@exxonmobil.com",
            "exela112.doe@exxonmobil.net",
            "alexbowman@apple.com",
            "dwasserman@yahoo.com",
            "chrismadison@aol.com",
            "chrismadison@gmail.com",
            "han@gm.net",
        ]

        let expectedResult = [
            "Exxon Mobil",
            "Exxon Mobil",
            "apple",
            "yahoo",
            "aol",
            "Google",
            "General Motors",
        ]

        // When
        let companyNames = emailsWithSimpleDomains.map {
            EmailHandler.extractCompanyName(fromEmail: $0)
        }

        // Then
        XCTAssertEqual(companyNames, expectedResult)
    }

    func test_extractCompanyName_fromEmailsWithSubdomains_returnsCompanyNames() {
        // Given
        let emailsWithSubdomains = [
            "user@sub1.sub2.gmail.com",
            "contact@sub1.sub2.sub3.sub4.apple.com",
            "sales@sub1.sub2.sub3.sub4.sub5.sub6.sub7.aol.com",
        ]

        let expectedResult = ["Google", "apple", "aol"]

        // When
        let companyNames = emailsWithSubdomains.map {
            EmailHandler.extractCompanyName(fromEmail: $0)
        }

        // Then
        XCTAssertEqual(companyNames, expectedResult)
    }

    func test_extractCompanyName_fromInvalidEmails_returnsNil() {
        // Given
        let invalidEmails = [
            "dodster.com",
            "klareton@exxonmobil,com",
            "alexbowman.apple.com",
            "dwasserman@111.222.333.44444",
            "chrismadison@aol@com",
            "chrismadison@gmail/dae.com",
        ]

        // When
        let companyNames = invalidEmails.map { EmailHandler.extractCompanyName(fromEmail: $0) }

        // Then
        companyNames.forEach { XCTAssertNil($0) }
    }

    func test_extractVerifiedCompanyName_fromDomains_returnsVerifiedCompanyName() {
        // Given
        let emailsWithVerifiedCompanyDomains = [
            "klareton@exxonmobil.com",
            "exela112.doe@att.net",
            "alexbowman@unitedhealthgroup.com",
            "dwasserman@sinopec.com",
            "chrismadison@cnpc.com",
            "chrismadison@toyota.com",
            "chrismadison@gmail.com",
            "han@berkshirehathaway.net",
            "han@gm.net",
            "han@alphabet.net",
        ]

        let expectedResult = [
            "Exxon Mobil",
            "AT&T",
            "UnitedHealth Group",
            "Sinopec Group",
            "China National Petroleum",

            "Toyota Motor",
            "Google",
            "Berkshire Hathaway",
            "General Motors",
            "Alphabet (Google)",
        ]

        // When
        let companyNames = emailsWithVerifiedCompanyDomains.map {
            EmailHandler.extractCompanyName(fromEmail: $0)
        }

        // Then
        XCTAssertEqual(companyNames, expectedResult)
    }

    func test_validateEmail_withValidEmails_returnsTrue() {
        // Given
        let validEmails = [
            "klareton@exxonmobil.com",
            "exela112.doe@att.net",
            "alexbowman@unitedhealthgroup.com",
            "dwasserman@sinopec.com",
            "chrismadison@cnpc.com",
            "chrismadison@toyota.com",
            "chrismadison@gmail.com",
            "han@berkshirehathaway.net",
            "han@gm.net",
            "han@alphabet.net",
        ]

        // When
        let domains = validEmails.map { EmailHandler.validateEmail($0) }

        // Then
        domains.forEach { XCTAssertTrue($0) }
    }

    func test_validateEmail_withInvalidEmails_returnsFalse() {
        // Given
        let invalidEmails = [
            "klareton@exxonmobil@com",
            "exela112.doeatt.net",
            "alexbowman@u_ni_tedhealthgroup_com",
            "dwasserman@111.222.333.44444",
            "chrismadiso$%#n@cnpc.com",
            "chrismadison@toyota",
            "あいうえお@gmail.com",
            "han@berkshirehathaway,net",
            "han%gm@bep%net",
            "han@alphabet+net",
        ]

        // When
        let domains = invalidEmails.map { EmailHandler.validateEmail($0) }

        // Then
        domains.forEach { XCTAssertFalse($0) }
    }
}
