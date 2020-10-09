//
//  ProofOfConceptInteractorTest.swift
//  WiproCodingExcerciseTests
//
//  Created by Prince Sojitra on 08/10/20.
//

import XCTest
@testable  import WiproCodingExcercise
class ProofOfConceptFeedInteractorTest: XCTestCase {
    
    // MARK: - Subject under test
    var sut: ProofOfConceptFeedInteractor!
    var apiServiceWorker :FeedsWorkerSpy!
    var listFeedsPresenter :FeedsListPresentationLogicSpy!
    static var testFeeds: ProofConceptFeedModel!
    
    // MARK: - Test lifecycle
    override  func setUp() {
        super.setUp()
        apiServiceWorker = FeedsWorkerSpy()
        listFeedsPresenter = FeedsListPresentationLogicSpy()
        sut = ProofOfConceptFeedInteractor(withService: apiServiceWorker)
        sut.presenter = listFeedsPresenter
        ProofOfConceptFeedInteractorTest.testFeeds = self.getTestFeedsData(jsonString: Seeds.Feeds.canada)
    }
    
    func getTestFeedsData(jsonString:String)-> ProofConceptFeedModel {
        let jsonData = jsonString.data(using: .utf8)!
        let proofOfConceptFeeds = try! JSONDecoder().decode(ProofConceptFeedModel.self, from: jsonData)
        return proofOfConceptFeeds
    }
    
    override  func tearDown() {
        super.tearDown()
        sut  = nil
        apiServiceWorker = nil
        listFeedsPresenter = nil
    }
    
    // MARK: - Test doubles
    
    class FeedsListPresentationLogicSpy: ProofOfConceptFeedPresenterProtocol
    {
        // MARK: Method call expectations
        var presentFetchedFeedsCalled = false
        
        // MARK: Spied methods
        func interactor(didRetriveProofOfConcpet profOfConcept: ProofConceptFeedModel) {
            presentFetchedFeedsCalled = true
        }
        
        func interactor(didRetriveFailProofOfConcpet error: APIError) {
            presentFetchedFeedsCalled = false
        }
    }
   
    class FeedsWorkerSpy: ProofOfConceptFeedServiceProtocol
    {
        // MARK: Method call expectations
        var fetchFeedsCalled = false
        
        // MARK: Spied methods
        func getProofOfConeptsFeeds(withLoader show: Bool, completionHandler: @escaping ReesultComplitionBlock) {
            fetchFeedsCalled = true
            completionHandler(.success(ProofOfConceptFeedInteractorTest.testFeeds))
        }
    }
    
    // MARK: - Tests
    
    func testFetchFeedsShouldAskFeedsWorkerToFetchFeedsAndPresenterToFormatResult()
    {
      // Given
        
      // When
      sut.fetchFeedsData(withLoader: true)
      
      // Then
      XCTAssert(apiServiceWorker.fetchFeedsCalled, "fetchFeedsData() should ask FeedsWorker to fetch fedds")
        XCTAssert(listFeedsPresenter.presentFetchedFeedsCalled, "fetchFeedsData() should ask presenter to format feeds result")
      
    }
}
