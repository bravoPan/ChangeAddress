import XCTest
@testable import CheckAddress

class AddAddressViewControllerTests: XCTestCase {

    var sut: AddAddressViewController!

    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "AddAddressViewController") as? AddAddressViewController
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_viewDidLoad_setsNavigationBarButtonsAndTitle() {
        sut.viewDidLoad()

        XCTAssertEqual(sut.navigationItem.title, "Add Address")
        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem?.action, #selector(AddAddressViewController.doneButtonTapped))
        XCTAssertNotNil(sut.navigationItem.leftBarButtonItem)
        XCTAssertEqual(sut.navigationItem.leftBarButtonItem?.action, #selector(AddAddressViewController.cancelButtonTapped))
    }

    func test_doneButtonTapped_withAllFieldsFilled_callsOnSaveAndPopsViewController() {
        // Given
        let expectation = self.expectation(description: "onSave called")
        sut.streetTextField.text = "123 Main St"
        sut.cityTextField.text = "Springfield"
        sut.stateTextField.text = "IL"
        sut.zipCodeTextField.text = "62704"

        var savedValues: (String, String, String, String)?
        sut.onSave = { street, city, state, zip in
            savedValues = (street, city, state, zip)
            expectation.fulfill()
        }

        let mockNav = MockNavigationController(rootViewController: sut)
        sut.doneButtonTapped()

        // Then
        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(savedValues?.0, "123 Main St")
        XCTAssertEqual(savedValues?.1, "Springfield")
        XCTAssertEqual(savedValues?.2, "IL")
        XCTAssertEqual(savedValues?.3, "62704")
        XCTAssertTrue(mockNav.didPopViewController)
    }

    func test_doneButtonTapped_withMissingFields_showsAlert() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddAddressViewController") as! AddAddressViewController

        let window = UIWindow()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        vc.loadViewIfNeeded()

        // Given
        vc.streetTextField.text = "123 Main St"
        vc.cityTextField.text = ""
        vc.stateTextField.text = "IL"
        vc.zipCodeTextField.text = "62704"

        // When
        vc.doneButtonTapped()

        // Then
        let exp = expectation(description: "Alert should be presented")
        DispatchQueue.main.async {
            let alert = vc.presentedViewController as? UIAlertController
            XCTAssertNotNil(alert)
            XCTAssertEqual(alert?.title, "Error")
            XCTAssertEqual(alert?.message, "Please fill in all fields")
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }

}

// MARK: - Mock Navigation Controller

class MockNavigationController: UINavigationController {
    var didPopViewController = false

    override func popViewController(animated: Bool) -> UIViewController? {
        didPopViewController = true
        return super.popViewController(animated: animated)
    }
}
