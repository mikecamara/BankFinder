# BankFinder

# Introduction

The iOS app downloads and parses three files in JSON format then lists the bank locations in [Estonia](https://www.swedbank.ee/finder.json), [Latvia](https://ib.swedbank.lv/finder.json) and [Lithuania](https://ib.swedbank.lt/finder.json).

![Alt text](screenshots/regionsHome.png?raw=true "Regions")

![Alt text](screenshots/bankDetailsDarkMode.png?raw=true "Bank Details")

# Architecture

Model View ViewModel Pattern (MVVC)

# Requirements

1 - List of all location regions with countries as section headers in alphabetical order.

![Alt text](screenshots/threeCountriesRegions.png?raw=true "Countries")

** RegionsList.swift

2 - List of all locations in the selected region in alphabetical order

![Alt text](screenshots/regionsBanks.png?raw=true "Region Banks")

** RegionBanksList.swift

3 - Details of the selected location

![Alt text](screenshots/bankDetails.png?raw=true "Bank Details")

** BankDetails.swift

4 - The app should download and parse 3 files with bank locations in JSON format.

** BanksViewModel.swift

5 - The app should save the files or the data in a local storage.

** BanksViewModel.swift

6 - The app should allow refreshing on the list of all location regions. 

![Alt text](screenshots/regionsHomeDarkMode.png?raw=true "Refresh Regions")

7 - The app should redownload the files at launch and on refresh once in 1 hour, otherwise, it should reuse the stored data.

** BanksViewModel.swift

8 - To download the files the app should set the given cookie.

** BanksViewModel.swift

9 - Use the latest version of Swift and Xcode, follow the Swift API design guidelines and support the latest major iOS versions.

// Built with SwiftUI 
// Xcode Version 11.5
// iOS 13.5.1
// Architecture - Model View ViewModel Pattern (MVVC)

10 - Do not use any third-party frameworks of libraries.

// No third-party frameworks of external libraries used

11 - Write production-ready code, clean, modular and testable.

** BankFinderTests.swift
** BankFinderUITests.swift


# Done but not required

- Display map of the bank location
![Alt text](screenshots/bankDetailsDarkMode.png?raw=true "Bank Location")

- Enable get directions to the bank
![Alt text](screenshots/getDirectionsToBank.png?raw=true "Bank Location")

- Enable sharing bank details
![Alt text](screenshots/shareBankDetails.png?raw=true "Bank Location")

- iOS dark mode compatible
![Alt text](screenshots/regionBanksDarkMode.png?raw=true "Bank Location")
