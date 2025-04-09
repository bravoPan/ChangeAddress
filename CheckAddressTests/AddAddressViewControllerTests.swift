import XCTest
@testable import CheckAddress

class AddAddressViewControllerTests: XCTestCase {
    
    var sut: AddAddressViewController!
    var saveExpectation: XCTestExpectation!
    var savedStreet: String?
    var savedCity: String?
    var savedState: String?
    var savedZipCode: String?
    
    override func setUp() {
        super.setUp()
        sut = AddAddressViewController()
        sut.loadViewIfNeeded()
        
        // Set up expectation for the save closure
        saveExpectation = expectation(description: "Save address")
        
        // Set up the save closure
        sut.onSave = { [weak self] street, city, state, zipCode in
            self?.savedStreet = street
            self?.savedCity = city
            self?.savedState = state
            self?.savedZipCode = zipCode
            self?.saveExpectation.fulfill()
        }
    }
    
    override func tearDown() {
        sut = nil
        saveExpectation = nil
        savedStreet = nil
        savedCity = nil
        savedState = nil
        savedZipCode = nil
        super.tearDown()
    }
    
    func testDoneButtonTappedWithEmptyFields() {
        // Given
        sut.streetTextField.text = ""
        sut.cityTextField.text = ""
        sut.stateTextField.text = ""
        sut.zipCodeTextField.text = ""
        
        // When
        sut.doneButtonTapped()
        
        // Then
        // The save closure should not be called
        XCTAssertNil(savedStreet)
        XCTAssertNil(savedCity)
        XCTAssertNil(savedState)
        XCTAssertNil(savedZipCode)
    }
    
    func testDoneButtonTappedWithValidFields() {
        // Given
        sut.streetTextField.text = "123 Test St"
        sut.cityTextField.text = "Test City"
        sut.stateTextField.text = "TS"
        sut.zipCodeTextField.text = "12345"
        
        // When
        sut.doneButtonTapped()
        
        // Then
        wait(for: [saveExpectation], timeout: 1.0)
        
        XCTAssertEqual(savedStreet, "123 Test St")
        XCTAssertEqual(savedCity, "Test City")
        XCTAssertEqual(savedState, "TS")
        XCTAssertEqual(savedZipCode, "12345")
    }
    
    func testCancelButtonTapped() {
        // Given
        let mockNavigationController = UINavigationController(rootViewController: sut)
        
        // When
        sut.cancelButtonTapped()
        
        // Then
        // The save closure should not be called
        XCTAssertNil(savedStreet)
        XCTAssertNil(savedCity)
        XCTAssertNil(savedState)
        XCTAssertNil(savedZipCode)
    }
}