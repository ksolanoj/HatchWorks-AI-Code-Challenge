//
//  FavoritesViewModelTests.swift
//  HatchWorksChallengeTests
//
//  Created by Kevin Solano Jiménez on 14/1/26.
//

@testable import HatchWorksChallenge
import Foundation
import Testing

@Suite("FavoritesViewModel Unit Tests")
struct FavoritesViewModelTests {

    @Test("Given a new ViewModel, When it is created, Then state is loading and list is empty")
    @MainActor
    func givenNewVM_whenInit_thenLoadingAndEmpty() async {
        // Given
        let repo = FavoritesRepositoryMock(getFavoritesResult: [])
        let useCase = GetFavoritesUseCase(repository: repo)

        // When
        let sut = FavoritesViewModel(getFavorites: useCase)

        // Then
        #expect(sut.screenState == .loading)
        #expect(sut.countries.isEmpty)
    }

    @Test("Given repository returns favorites, When getFavoriteCountries is called, Then state is loaded and countries are assigned")
    @MainActor
    func givenFavoritesExist_whenGetFavoriteCountries_thenLoadedAndAssigned() async {
        // Given
        let expected = FavoritesRepositoryMock.successResponse
        let repo = FavoritesRepositoryMock(getFavoritesResult: expected)
        let useCase = GetFavoritesUseCase(repository: repo)
        let sut = FavoritesViewModel(getFavorites: useCase)

        // When
        sut.getFavoriteCountries()

        // Then
        #expect(sut.screenState == .loaded)
        #expect(sut.countries == expected)
    }

    @Test("Given repository returns empty favorites, When getFavoriteCountries is called, Then state is noFavorites and countries is empty")
    @MainActor
    func givenNoFavorites_whenGetFavoriteCountries_thenNoFavoritesAndEmpty() async {
        // Given
        let repo = FavoritesRepositoryMock(getFavoritesResult: [])
        let useCase = GetFavoritesUseCase(repository: repo)
        let sut = FavoritesViewModel(getFavorites: useCase)

        // When
        sut.getFavoriteCountries()

        // Then
        #expect(sut.screenState == .noFavorites)
        #expect(sut.countries.isEmpty)
    }
}
