//
//  CountryDetailViewModelTests.swift
//  HatchWorksChallengeTests
//
//  Created by Kevin Solano Jiménez on 14/1/26.
//

@testable import HatchWorksChallenge
import Foundation
import Testing

@Suite("CountryDetailViewModel Unit Tests")
struct CountryDetailViewModelTests {
    
    private let tappedCountry = Country(
        name: "Costa Rica",
        flagURL: URL(string: "https://example.com/cr.png"),
        population: 5_200_000
    )
    
    @Test("Given a new ViewModel, When it is created, Then state is loading and icon is star")
    @MainActor
    func givenNewVM_whenInit_thenLoadingAndStarIcon() async {
        // Given
        let detailRepo = CountryDetailRepositoryMock()
        let favoritesRepo = FavoritesRepositoryMock(isFavoriteResult: .success(false))
        
        let getDetailUC = GetCountryDetailUseCase(countryDetailRepository: detailRepo)
        let addFavUC = AddToFavoritesUseCase(repository: favoritesRepo)
        let removeFavUC = RemoveFromFavoritesUseCase(repository: favoritesRepo)
        let isFavUC = IsFavoriteUseCase(repository: favoritesRepo)
        
        // When
        let sut =  CountryDetailViewModel(
            tappedCountry: tappedCountry,
            getCountryDetailUseCase: getDetailUC,
            addToFavoritesUseCase: addFavUC,
            removeFromFavoritesUseCase: removeFavUC,
            isFavoriteUseCase: isFavUC
        )
        
        // Then
        #expect(sut.screenState == .loading)
        #expect(sut.addToFavoritesButtonIcon == "star")
    }
    
    @Test("Given detail succeeds and country is NOT favorite, When getCountryDetail is called, Then state is loaded and icon stays star")
    @MainActor
    func givenNotFavorite_whenGetCountryDetail_thenLoadedAndStarIcon() async {
        // Given
        let detailRepo = CountryDetailRepositoryMock()
        let favoritesRepo = FavoritesRepositoryMock(isFavoriteResult: .success(false))
        
        let getDetailUC = GetCountryDetailUseCase(countryDetailRepository: detailRepo)
        let addFavUC = AddToFavoritesUseCase(repository: favoritesRepo)
        let removeFavUC = RemoveFromFavoritesUseCase(repository: favoritesRepo)
        let isFavUC = IsFavoriteUseCase(repository: favoritesRepo)
        
        let sut =  CountryDetailViewModel(
            tappedCountry: tappedCountry,
            getCountryDetailUseCase: getDetailUC,
            addToFavoritesUseCase: addFavUC,
            removeFromFavoritesUseCase: removeFavUC,
            isFavoriteUseCase: isFavUC
        )
        
        // When
        await sut.getCountryDetail()
        
        // Then
        #expect(sut.screenState == .loaded)
        #expect(sut.addToFavoritesButtonIcon == "star")
    }
    
    @Test("Given detail succeeds and country IS favorite, When getCountryDetail is called, Then state is loaded and icon becomes star.fill")
    @MainActor
    func givenFavorite_whenGetCountryDetail_thenLoadedAndStarFillIcon() async {
        // Given
        let detailRepo = CountryDetailRepositoryMock()
        let favoritesRepo = FavoritesRepositoryMock(isFavoriteResult: .success(true))
        
        let getDetailUC = GetCountryDetailUseCase(countryDetailRepository: detailRepo)
        let addFavUC = AddToFavoritesUseCase(repository: favoritesRepo)
        let removeFavUC = RemoveFromFavoritesUseCase(repository: favoritesRepo)
        let isFavUC = IsFavoriteUseCase(repository: favoritesRepo)
        
        let sut =  CountryDetailViewModel(
            tappedCountry: tappedCountry,
            getCountryDetailUseCase: getDetailUC,
            addToFavoritesUseCase: addFavUC,
            removeFromFavoritesUseCase: removeFavUC,
            isFavoriteUseCase: isFavUC
        )
        
        // When
        await sut.getCountryDetail()
        
        // Then
        #expect(sut.screenState == .loaded)
        #expect(sut.addToFavoritesButtonIcon == "star.fill")
    }
    
    @Test("Given detail fails, When getCountryDetail is called, Then state is error")
    @MainActor
    func givenDetailFails_whenGetCountryDetail_thenError() async {
        // Given
        let detailRepo = CountryDetailRepositoryMock(result: .failure(RequestError.somethingWentWrong))
        let favoritesRepo = FavoritesRepositoryMock(isFavoriteResult: .success(false))
        
        let getDetailUC = GetCountryDetailUseCase(countryDetailRepository: detailRepo)
        let addFavUC = AddToFavoritesUseCase(repository: favoritesRepo)
        let removeFavUC = RemoveFromFavoritesUseCase(repository: favoritesRepo)
        let isFavUC = IsFavoriteUseCase(repository: favoritesRepo)
        
        let sut =  CountryDetailViewModel(
            tappedCountry: tappedCountry,
            getCountryDetailUseCase: getDetailUC,
            addToFavoritesUseCase: addFavUC,
            removeFromFavoritesUseCase: removeFavUC,
            isFavoriteUseCase: isFavUC
        )
        
        // When
        await sut.getCountryDetail()
        
        // Then
        #expect(sut.screenState == .error)
    }
    
    @Test("Given country is NOT favorite, When addToFavoritesAction is called, Then add is called and icon becomes star.fill")
    @MainActor
    func givenNotFavorite_whenAddToFavoritesAction_thenAddCalledAndStarFill() async {
        // Given
        let detailRepo = CountryDetailRepositoryMock()
        let favoritesRepo = FavoritesRepositoryMock(isFavoriteResult: .success(false))
        
        let getDetailUC = GetCountryDetailUseCase(countryDetailRepository: detailRepo)
        let addFavUC = AddToFavoritesUseCase(repository: favoritesRepo)
        let removeFavUC = RemoveFromFavoritesUseCase(repository: favoritesRepo)
        let isFavUC = IsFavoriteUseCase(repository: favoritesRepo)
        
        let sut =  CountryDetailViewModel(
            tappedCountry: tappedCountry,
            getCountryDetailUseCase: getDetailUC,
            addToFavoritesUseCase: addFavUC,
            removeFromFavoritesUseCase: removeFavUC,
            isFavoriteUseCase: isFavUC
        )
        
        // When
        sut.addToFavoritesAction()
        
        // Then
        #expect(favoritesRepo.addToFavoritesCalled == true)
        #expect(favoritesRepo.removeFromFavoritesCalled == false)
        #expect(sut.addToFavoritesButtonIcon == "star.fill")
    }
    
    @Test("Given country IS favorite, When addToFavoritesAction is called, Then remove is called and icon becomes star")
    @MainActor
    func givenFavorite_whenAddToFavoritesAction_thenRemoveCalledAndStar() async {
        // Given
        let detailRepo = CountryDetailRepositoryMock()
        let favoritesRepo = FavoritesRepositoryMock(isFavoriteResult: .success(true))
        
        let getDetailUC = GetCountryDetailUseCase(countryDetailRepository: detailRepo)
        let addFavUC = AddToFavoritesUseCase(repository: favoritesRepo)
        let removeFavUC = RemoveFromFavoritesUseCase(repository: favoritesRepo)
        let isFavUC = IsFavoriteUseCase(repository: favoritesRepo)
        
        let sut = CountryDetailViewModel(
            tappedCountry: tappedCountry,
            getCountryDetailUseCase: getDetailUC,
            addToFavoritesUseCase: addFavUC,
            removeFromFavoritesUseCase: removeFavUC,
            isFavoriteUseCase: isFavUC
        )
        
        // When
        sut.addToFavoritesAction()
        
        // Then
        #expect(favoritesRepo.addToFavoritesCalled == false)
        #expect(favoritesRepo.removeFromFavoritesCalled == true)
        #expect(sut.addToFavoritesButtonIcon == "star")
    }
}
