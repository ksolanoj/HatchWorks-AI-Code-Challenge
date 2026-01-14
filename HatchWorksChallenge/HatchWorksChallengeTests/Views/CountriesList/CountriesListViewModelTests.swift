//
//  CountriesListViewModelTests.swift
//  HatchWorksChallengeTests
//
//  Created by Kevin Solano Jiménez on 14/1/26.
//

@testable import HatchWorksChallenge
import Foundation
import Testing


@Suite("CountriesListViewModel Unit Tests")
struct CountriesListViewModelTests {

    @Test("Given a new ViewModel, When it is created, Then state is loading and list is empty")
    @MainActor
    func initialState_givenNewVM_whenInit_thenLoadingAndEmpty() async {
        // Given
        let repo = CountriesRepositoryMock()
        let useCase = GetCountriesUseCase(countriesRepository: repo)

        // When
        let sut = CountriesListViewModel(getCountriesUseCase: useCase)

        // Then
        #expect(sut.screenState == .loading)
        #expect(sut.allCountries.isEmpty)
    }

    @Test("Given repository returns countries, When getCountries is called, Then state is loaded and countries are assigned")
    @MainActor
    func getCountriesSuccess_givenRepoSuccess_whenGetCountries_thenLoadedAndAssigned() async {
        // Given
        let expected = CountriesRepositoryMock.successResponse
        let repo = CountriesRepositoryMock(result: .success(expected))
        let useCase = GetCountriesUseCase(countriesRepository: repo)
        let sut = CountriesListViewModel(getCountriesUseCase: useCase)

        // When
        await sut.getCountries()

        // Then
        #expect(sut.screenState == .loaded)
        #expect(sut.allCountries == expected)
    }

    
    @Test("Given repository fails, When getCountries is called, Then state is error and list remains empty")
    @MainActor
    func getCountriesFailure_givenRepoFailure_whenGetCountries_thenErrorAndEmpty() async {
        // Given
        let repo = CountriesRepositoryMock(result: .failure(RequestError.somethingWentWrong))
        let useCase = GetCountriesUseCase(countriesRepository: repo)
        let sut = CountriesListViewModel(getCountriesUseCase: useCase)

        // When
        await sut.getCountries()

        // Then
        #expect(sut.screenState == .error)
        #expect(sut.allCountries.isEmpty)
    }
}
