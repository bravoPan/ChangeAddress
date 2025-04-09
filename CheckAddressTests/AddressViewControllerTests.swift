import XCTest
@testable import CheckAddress

class AddressViewControllerTests: XCTestCase {
    
    var sut: AddressViewController!
    
    override func setUp() {
        super.setUp()
        sut = AddressViewController()
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testInitialAddressArray() {
        // Then
        XCTAssertEqual(sut.addressArray.count, 1)
        
        let firstAddress = sut.addressArray.first
        XCTAssertEqual(firstAddress?.street, "Abou El-Fotouh Abd Allah")
        XCTAssertEqual(firstAddress?.city, "Cairo")
        XCTAssertEqual(firstAddress?.state, "Egypt")
        XCTAssertEqual(firstAddress?.zipCode, "022")
    }
    
    func testTableViewNumberOfRows() {
        // Given
        let tableView = sut.tableView
        
        // When
        let numberOfRows = sut.tableView(tableView!, numberOfRowsInSection: 0)
        
        // Then
        XCTAssertEqual(numberOfRows, sut.addressArray.count)
    }
    
    func testAddAddress() {
        // Given
        let initialCount = sut.addressArray.count
        let newAddress = Address(street: "New Street", city: "New City", state: "New State", zipCode: "12345")
        
        // When
        sut.addressArray.append(newAddress)
        
        // Then
        XCTAssertEqual(sut.addressArray.count, initialCount + 1)
        XCTAssertEqual(sut.addressArray.last?.street, "New Street")
        XCTAssertEqual(sut.addressArray.last?.city, "New City")
        XCTAssertEqual(sut.addressArray.last?.state, "New State")
        XCTAssertEqual(sut.addressArray.last?.zipCode, "12345")
    }
} 
