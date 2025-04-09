import XCTest
@testable import CheckAddress

class AddressTests: XCTestCase {
    
    func testAddressInitialization() {
        // Given
        let street = "123 Main St"
        let city = "New York"
        let state = "NY"
        let zipCode = "10001"
        
        // When
        let address = Address(street: street, city: city, state: state, zipCode: zipCode)
        
        // Then
        XCTAssertEqual(address.street, street)
        XCTAssertEqual(address.city, city)
        XCTAssertEqual(address.state, state)
        XCTAssertEqual(address.zipCode, zipCode)
    }
    
    func testAddressEquality() {
        // Given
        let address1 = Address(street: "123 Main St", city: "New York", state: "NY", zipCode: "10001")
        let address2 = Address(street: "123 Main St", city: "New York", state: "NY", zipCode: "10001")
        let address3 = Address(street: "456 Oak Ave", city: "Boston", state: "MA", zipCode: "02108")
        
        // Then
        XCTAssertEqual(address1.street, address2.street)
        XCTAssertEqual(address1.city, address2.city)
        XCTAssertEqual(address1.state, address2.state)
        XCTAssertEqual(address1.zipCode, address2.zipCode)
        
        XCTAssertNotEqual(address1.street, address3.street)
        XCTAssertNotEqual(address1.city, address3.city)
        XCTAssertNotEqual(address1.state, address3.state)
        XCTAssertNotEqual(address1.zipCode, address3.zipCode)
    }
} 