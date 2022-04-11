import XCTest
import SwiftUI
@testable import NiftyMarkdownFormatter

final class NiftyMarkdownFormatterTests: XCTestCase {
    
    // MARK: Header
    func testHeaderConversion() throws {
        let testString = "# Test"
        let expected = Heading(text: "Test", headingSize: 1)
        let actual = convertMarkdownHeading(testString)
        XCTAssertEqual(expected.text, actual.text)
        XCTAssertEqual(expected.headingSize, actual.headingSize)
    }
    
    func testHeaderConversion2() throws {
        let testString = "## Another test"
        let expected = Heading(text: "Another test", headingSize: 2)
        let actual = convertMarkdownHeading(testString)
        XCTAssertEqual(expected.text, actual.text)
        XCTAssertEqual(expected.headingSize, actual.headingSize)
    }

    // MARK: Image
    func testImageConversionFromEmpty() throws {
        let testString = "![]()"
        let expected = ("", URL(string: ""))
        let actual = formatImageComponents(testString)
        XCTAssertEqual(expected.0, actual.0)
        XCTAssertEqual(expected.1, actual.1)
    }

    func testImageConversionEmptyAltText() throws {
        let testString = "![](http://www.google.com/)"
        let expected = ("", URL(string: "http://www.google.com/"))
        let actual = formatImageComponents(testString)
        XCTAssertEqual(expected.0, actual.0)
        XCTAssertEqual(expected.1, actual.1)
    }

    func testImageConversion() throws {
        let testString = "![Google](http://www.google.com/)"
        let expected = ("Google", URL(string: "http://www.google.com/"))
        let actual = formatImageComponents(testString)
        XCTAssertEqual(expected.0, actual.0)
        XCTAssertEqual(expected.1, actual.1)
    }

    func testImageConversionEmptyUrl() throws {
        let testString = "![Google]()"
        let expected = ("Google", URL(string: ""))
        let actual = formatImageComponents(testString)
        XCTAssertEqual(expected.0, actual.0)
        XCTAssertEqual(expected.1, actual.1)
    }

    // MARK: Ordered list
    func testOrderedList() throws {
        throw XCTSkip("Need to fix the test, expected failure not working either")
        let testString = "1. List item"
        let excepted = "**1.** List item"
        let actual = formatOrderedListItem(testString)
        XCTAssertEqual(excepted, "actual")
    }
    
    func testOrderedList2() throws {
        throw XCTSkip("Need to fix the test, expected failure not working either")
        let testString = "9. List item"
        let excepted = "**9.** List item"
        let actual = formatOrderedListItem(testString)
        XCTAssertEqual(excepted, "actual")
    }
    
    func testOrderedListWithWrongInput() throws {
        throw XCTSkip("Need to fix the test, expected failure not working either")
        let testString = "No correct prefix."
        let expected = testString
        let actual = formatOrderedListItem(testString)
        XCTAssertEqual(expected, "actual")
    }
    
    // MARK: Unordered list
    func testUnorderedList() throws {
        let testString = "* List item"
        let excepted = "List item"
        let actual = formatUnorderedListItem(testString)
        XCTAssertEqual(excepted, actual)
    }
    
    func testUnorderedList2() throws {
        let testString = "* List item"
        let excepted = "List item"
        let actual = formatUnorderedListItem(testString)
        XCTAssertEqual(excepted, actual)
    }
    
    func testUnorderedListWithWrongInput() throws {
        let testString = "No correct prefix."
        let expected = testString
        let actual = formatUnorderedListItem(testString)
        XCTAssertEqual(expected, actual)
    }
}
