import XCTest
import ViewInspector
@testable import EnvError

extension ContentView: Inspectable { }
extension CountView: Inspectable { }

class EnvErrorTests: XCTestCase {
    func testToggleView() throws {
        var sut = ContentView()
        let exp = sut.on(\.didAppear) { view in
            XCTAssertThrowsError(try view.find(text: "Count: 1"))
            try XCTUnwrap(view.find(button: "Show count")).tap()
            XCTAssertNotNil(try view.find(text: "Count: 1"))
        }
        ViewHosting.host(view: sut.environment(\.managedObjectContext, PersistenceController.test.container.viewContext))
        wait(for: [exp], timeout: 0.1)
    }
}
