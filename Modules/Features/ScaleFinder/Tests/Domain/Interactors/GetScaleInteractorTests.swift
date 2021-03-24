import Foundation
import XCTest
import Resolver
import Combine
@testable import ScaleFinder

fileprivate let scales = [
    Scale(
        rootNote: "C",
        mode: "major",
        notes: "C D E F G A B"
    ),
    Scale(
        rootNote: "E",
        mode: "minor",
        notes: "E F# G A B C D"
    )
]

final class GetScalesInteractorTests: XCTestCase {
    
    private let sut = GetScalesInteractor()
    
    func test_shouldCallGetScalesOnRepository() {
        // Arrange
        let repository = ScaleFinderRepositorySpy()
        Resolver.register { repository as ScaleFinderRepository }
        repository.getScalesSuccess()
        
        // Act
        _ = sut.execute(withRequestValues: GetScalesRequestValues(notes: "C"))
        
        // Expect
        XCTAssertTrue(repository.getScalesCalled)
    }
    
    func test_getScalesShouldReturnExpectedSet() {
        // Arrange
        let repository = ScaleFinderRepositorySpy()
        Resolver.register { repository as ScaleFinderRepository }
        repository.getScalesSuccess()
        
        let expectation = XCTestExpectation(description: "scales")
        
        // Act
        _ = sut.execute(withRequestValues: GetScalesRequestValues(notes: "C"))
            .sink(receiveCompletion: { _ in}) { response in
                XCTAssertEqual(response, scales)
                expectation.fulfill()
        }
        
        // Expect
        wait(for: [expectation], timeout: 1)
        
    }
    
    func test_getScalesShouldReturnError() {
        // Arrange
        let repository = ScaleFinderRepositorySpy()
        Resolver.register { repository as ScaleFinderRepository }
        repository.getScalesFailure()
        
        let expectation = XCTestExpectation(description: "scales")
        
        // Act
        _ = sut.execute(withRequestValues: GetScalesRequestValues(notes: "C"))
            
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    expectation.fulfill()
                } else {
                    XCTFail()
                }
                
            }) { _ in }
        
        // Expect
        wait(for: [expectation], timeout: 1)
        
    }
    
}

private final class ScaleFinderRepositorySpy: ScaleFinderRepository {
    
    private(set) var getScalesCalled = false
    
    private var result: Future<[Scale], Error>!
    
    func getScales(notes: String) -> AnyPublisher<[Scale], Error> {
        getScalesCalled = true
        return result.eraseToAnyPublisher()
    }
    
    func getScalesSuccess() {
        result = Future<[Scale], Error> { promise in
            promise(.success(scales))
        }
    }
    
    func getScalesFailure() {
        let error = NSError(domain: "GetScaleInteractorTests", code: -1, userInfo: nil)
        result = Future<[Scale], Error> { promise in
            promise(.failure(error as Error))
        }
    }
    
}
