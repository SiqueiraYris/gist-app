import XCTest
import NetworkKit
@testable import GistDetailKit

final class GistDetailViewModelTests: XCTestCase {
    func test_fetchData_callsServiceAndUpdatesContent_onSuccess() {
        let dataSource = GistDetailDataSource.fixture(content: nil)
        let (sut, _, serviceSpy, _) = makeSUT(dataSource: dataSource)
        let content = "Fetched content"
        
        serviceSpy.result = .success(content)
        serviceSpy.downloadImageResult = Data()
        sut.fetch()
        serviceSpy.completeWithSuccess(object: content)

        XCTAssertFalse(sut.isLoading.value)
        XCTAssertEqual(sut.content.value, content)
        XCTAssertEqual(sut.showData.value, true)
    }

    func test_fetchData_callsServiceAndUpdatesError_onFailure() {
        let dataSource = GistDetailDataSource.fixture(content: nil)
        let (sut, _, serviceSpy, _) = makeSUT(dataSource: dataSource)
        let error = ResponseError.fixture()
        
        serviceSpy.result = .failure(error)
        serviceSpy.downloadImageResult = Data()
        sut.fetch()
        serviceSpy.completeWithError(error: error)

        XCTAssertFalse(sut.isLoading.value)
        XCTAssertEqual(sut.error.value, error.errorDescription)
    }

    func test_getData_returnsCorrectDefaultItemData() {
        let dataSource = GistDetailDataSource.fixture()
        let (sut, _, _, _) = makeSUT(dataSource: dataSource)

        let result = sut.getData()

        XCTAssertEqual(result?.title, Strings.userNameTitle.appending(dataSource.userName ?? ""))
        XCTAssertEqual(result?.subtitle, Strings.filesQuantityTitle.appending("\(dataSource.filesQuantity)"))
        XCTAssertEqual(result?.image, dataSource.avatarURL)
        XCTAssertEqual(result?.imageData, dataSource.imageData)
    }

    func test_getTitleData_returnsCorrectTitle() {
        let dataSource = GistDetailDataSource.fixture()
        let (sut, _, _, _) = makeSUT(dataSource: dataSource)

        let result = sut.getTitleData()

        XCTAssertEqual(result, Strings.fileTitle.appending(dataSource.filename ?? ""))
    }

    func test_copyContent_copiesTextToClipboard() {
        let dataSource = GistDetailDataSource.fixture()
        let (sut, _, _, _) = makeSUT(dataSource: dataSource)

        let textToCopy = "Some content"
        sut.copyContent(text: textToCopy)

        XCTAssertEqual(UIPasteboard.general.string, textToCopy)
    }

    func test_favoriteItem_savesOrDeletesItemCorrectly() {
        let dataSource = GistDetailDataSource.fixture()
        let (sut, coordinatorSpy, _, storageProviderSpy) = makeSUT(dataSource: dataSource)

        storageProviderSpy.isFavoritedResult = false
        storageProviderSpy.saveDataResult = true

        sut.favoriteItem()

        XCTAssertTrue(storageProviderSpy.receivedMessages.contains(.saveData(dataSource: dataSource)))
        XCTAssertTrue(sut.isFavorited.value)
        XCTAssertFalse(coordinatorSpy.receivedMessages.contains(.showErrorAlert(message: Strings.genericErrorMessage)))

        storageProviderSpy.isFavoritedResult = true
        storageProviderSpy.deleteResult = true

        sut.favoriteItem()

        XCTAssertTrue(storageProviderSpy.receivedMessages.contains(.deleteItem(id: dataSource.id)))
        XCTAssertFalse(sut.isFavorited.value)
        XCTAssertFalse(coordinatorSpy.receivedMessages.contains(.showErrorAlert(message: Strings.genericErrorMessage)))
    }

    func test_favoriteItem_showsErrorAlertOnSaveFailure() {
        let dataSource = GistDetailDataSource.fixture()
        let (sut, coordinatorSpy, _, storageProviderSpy) = makeSUT(dataSource: dataSource)

        storageProviderSpy.isFavoritedResult = false
        storageProviderSpy.saveDataResult = false

        sut.favoriteItem()

        XCTAssertEqual(coordinatorSpy.receivedMessages, [.showErrorAlert(message: Strings.genericErrorMessage)])
    }

    func test_favoriteItem_showsErrorAlertOnDeleteFailure() {
        let dataSource = GistDetailDataSource.fixture()
        let (sut, coordinatorSpy, _, storageProviderSpy) = makeSUT(dataSource: dataSource)

        storageProviderSpy.isFavoritedResult = true
        storageProviderSpy.deleteResult = false

        sut.favoriteItem()

        XCTAssertEqual(coordinatorSpy.receivedMessages, [.showErrorAlert(message: Strings.genericErrorMessage)])
    }

    func test_getIcon_returnsCorrectIconBasedOnFavoriteState() {
        let dataSource = GistDetailDataSource.fixture()
        let (sut, _, _, storageProviderSpy) = makeSUT(dataSource: dataSource)

        storageProviderSpy.isFavoritedResult = true
        XCTAssertEqual(sut.getIcon(), "star.fill")

        storageProviderSpy.isFavoritedResult = false
        XCTAssertEqual(sut.getIcon(), "star")
    }

    // MARK: - Helpers

    private func makeSUT(dataSource: GistDetailDataSource) -> (
        sut: GistDetailViewModel,
        coordinatorSpy: GistDetailCoordinatorSpy,
        serviceSpy: GistDetailServiceSpy,
        storageProviderSpy: GistDetailStorageProviderSpy
    ) {
        let coordinatorSpy = GistDetailCoordinatorSpy()
        let serviceSpy = GistDetailServiceSpy()
        let storageProviderSpy = GistDetailStorageProviderSpy()

        let sut = GistDetailViewModel(
            coordinator: coordinatorSpy,
            service: serviceSpy,
            storageProvider: storageProviderSpy,
            dataSource: dataSource
        )

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(coordinatorSpy)
        trackForMemoryLeaks(serviceSpy)
        trackForMemoryLeaks(storageProviderSpy)

        return (
            sut,
            coordinatorSpy,
            serviceSpy, 
            storageProviderSpy
        )
    }

    private func makeError() -> NSError {
        return NSError(domain: "any-domain", code: 1)
    }
}
