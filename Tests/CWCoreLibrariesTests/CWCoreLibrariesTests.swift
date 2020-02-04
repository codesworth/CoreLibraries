import XCTest
@testable import CWCoreLibraries

final class CWCoreLibrariesTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CWCoreLibraries().text, "Hello, World!")
    }
    
    

    static var allTests = [
        ("testExample", testExample),
    ]
}
