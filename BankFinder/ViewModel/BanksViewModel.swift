//
//  BanksViewModel.swift
//  BankFinder
//
//  Created by Mike Camara on 22/6/20.
//  Copyright © 2020 Mike Camara. All rights reserved.
//

import Foundation

let apiUrlEstonia = "https://www.swedbank.ee/finder.json"
let apiUrlLatvia = "https://ib.swedbank.lv/finder.json"
let apiUrlLithuania = "https://ib.swedbank.lt/finder.json"

class BanksViewModel: ObservableObject, Identifiable {
    @Published var banksEstonia: [BankLocation] = []
    @Published var arrayOfEstoniaRegions: [Region] = []
    @Published var banksInEstoniaRegion: [BankLocation] = []
    var arrayOfEstoniaRegionsStrings: [String] = []
    
    @Published var banksLatvia: [BankLocation] = []
    @Published var arrayOfLatviaRegions: [Region] = []
    @Published var banksInLatviaRegion: [BankLocation] = []
    var arrayOfLatviaRegionsStrings: [String] = []
    
    @Published var banksLithuania: [BankLocation] = []
    @Published var arrayOfLithuaniaRegions: [Region] = []
    @Published var banksInLithuaniaRegion: [BankLocation] = []
    var arrayOfLithuaniaRegionsStrings: [String] = []
        
    func fetchBanksFromRegion(regionName: String, countryName: String){
        banksInEstoniaRegion = []
        banksInLithuaniaRegion = []
        banksInLatviaRegion = []
        if countryName == "Estonia" {
            fetchEstonianBanks()
            for bank in self.banksEstonia {
                if (bank.r == regionName) {
                    if !self.banksInEstoniaRegion.contains(where: { $0.n?.capitalized == bank.n?.capitalized }) {
                        var bankToAdd: BankLocation = BankLocation(t: bank.t, n: bank.n?.capitalized, a: bank.a?.capitalized , r: bank.r, av: bank.av, lat: bank.lat, lon: bank.lon, i: bank.i)
                        self.banksInEstoniaRegion.append(bankToAdd)
                    }
                }
            }
            self.arrayOfEstoniaRegions = self.arrayOfEstoniaRegions.sorted(by: {  $0.regionName ?? "" < $1.regionName ?? "" })
            self.banksInEstoniaRegion = self.banksInEstoniaRegion.sorted(by: {  $0.n ?? "" < $1.n ?? "" })
        } else if countryName == "Latvia" {
            fetchLatvianBanks()
            for bank in self.banksLatvia {
                if (bank.r == regionName) {
                    if !self.banksInLatviaRegion.contains(where: { $0.n?.capitalized == bank.n?.capitalized }) {
                        var bankToAdd: BankLocation = BankLocation(t: bank.t, n: bank.n?.capitalized, a: bank.a?.capitalized , r: bank.r, av: bank.av, lat: bank.lat, lon: bank.lon, i: bank.i)
                         self.banksInLatviaRegion.append(bankToAdd)
                    }
                }
            }
            self.arrayOfLatviaRegions = self.arrayOfLatviaRegions.sorted(by: {  $0.regionName ?? "" < $1.regionName ?? "" })
            self.banksInLatviaRegion = self.banksInLatviaRegion.sorted(by: {  $0.n ?? "" < $1.n ?? "" })
        } else {
            fetchLithuaniaBanks()
            for bank in self.banksLithuania {
                if (bank.r == regionName) {
                    if !self.banksInLithuaniaRegion.contains(where: { $0.n?.capitalized == bank.n?.capitalized }) {
                        var bankToAdd: BankLocation = BankLocation(t: bank.t, n: bank.n?.capitalized, a: bank.a?.capitalized , r: bank.r, av: bank.av, lat: bank.lat, lon: bank.lon, i: bank.i)
                         self.banksInLithuaniaRegion.append(bankToAdd)
                    }
                }
            }
            self.arrayOfLithuaniaRegions = self.arrayOfLithuaniaRegions.sorted(by: {  $0.regionName ?? "" < $1.regionName ?? "" })
            self.banksInLithuaniaRegion = self.banksInLithuaniaRegion.sorted(by: {  $0.n ?? "" < $1.n ?? "" })
        }
    }
    
    static func saveAllObjects(allObjects: [BankLocation], key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(allObjects){
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    static var getAllEstonianBanks: [BankLocation] {
        let defaultObject =  BankLocation(t: 0, n: "s", a: "a", r: "No banks available", av: "r", lat: 0.0, lon: 0.0, i: "t")
        if let objects = UserDefaults.standard.value(forKey: "SavedEstonianBanks") as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [BankLocation] {
                return objectsDecoded
            } else {
                return [defaultObject]
            }
        } else {
            return [defaultObject]
        }
    }
    
    static var getAllLatvianBanks: [BankLocation] {
       let defaultObject =  BankLocation(t: 0, n: "s", a: "a", r: "No banks available", av: "r", lat: 0.0, lon: 0.0, i: "t")
       if let objects = UserDefaults.standard.value(forKey: "SavedLatvianBanks") as? Data {
          let decoder = JSONDecoder()
          if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [BankLocation] {
             return objectsDecoded
          } else {
             return [defaultObject]
          }
       } else {
          return [defaultObject]
       }
    }
    
    static var getAllLithuanianBanks: [BankLocation] {
       let defaultObject =  BankLocation(t: 0, n: "s", a: "a", r: "No banks available", av: "r", lat: 0.0, lon: 0.0, i: "t")
       if let objects = UserDefaults.standard.value(forKey: "SavedLithuanianBanks") as? Data {
          let decoder = JSONDecoder()
          if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [BankLocation] {
             return objectsDecoded
          } else {
             return [defaultObject]
          }
       } else {
          return [defaultObject]
       }
    }
    
    func fetchEstonianBanks(){
        var arrayOfEstonianBanksSaved: [BankLocation] = []
        let defaults = UserDefaults.standard
        if let savedEstonianBanks = defaults.object(forKey: "SavedEstonianBanks") as? Data {
            arrayOfEstonianBanksSaved = BanksViewModel.getAllEstonianBanks
            self.banksEstonia = arrayOfEstonianBanksSaved
        }
        
        if (arrayOfEstonianBanksSaved.count > 0){
            for bank in arrayOfEstonianBanksSaved {
                if (!self.arrayOfEstoniaRegionsStrings.contains(bank.r ?? "")) {
                    self.arrayOfEstoniaRegionsStrings.append(bank.r ?? "")
                    let region: Region = Region(regionName: bank.r ?? "")
                    self.arrayOfEstoniaRegions.append(region)
                }
            }
            self.arrayOfEstoniaRegions = self.arrayOfEstoniaRegions.sorted(by: {  $0.regionName ?? "" < $1.regionName ?? "" })
        } else {
            refreshEstonianBanks()
        }
    }
    
    func refreshEstonianBanks() {
        guard let urlEesti = URL(string: apiUrlEstonia) else {return}
        URLSession.shared.dataTask(with: urlEesti) { (data, resp, err) in
            DispatchQueue.main.async {
                self.setCookie(domain: ".swedbank.ee")
                self.banksEstonia = try! JSONDecoder().decode([BankLocation].self, from: data!)
                BanksViewModel.saveAllObjects(allObjects: self.banksEstonia, key: "SavedEstonianBanks")
                    
                for bank in self.banksEstonia {
                    if (!self.arrayOfEstoniaRegionsStrings.contains(bank.r ?? "")) {
                        self.arrayOfEstoniaRegionsStrings.append(bank.r ?? "")
                        let region: Region = Region(regionName: bank.r ?? "")
                        self.arrayOfEstoniaRegions.append(region)
                    }
                }
                self.arrayOfEstoniaRegions = self.arrayOfEstoniaRegions.sorted(by: {  $0.regionName ?? "" < $1.regionName ?? "" })
            }
        }.resume()
    }
    
    func fetchLatvianBanks(){
        var arrayOfLatvianBanksSaved: [BankLocation] = []
        let defaults = UserDefaults.standard
        if let savedLatvianBanks = defaults.object(forKey: "SavedLatvianBanks") as? Data {
            arrayOfLatvianBanksSaved = BanksViewModel.getAllLatvianBanks
            self.banksLatvia = arrayOfLatvianBanksSaved
        }
        
        if (arrayOfLatvianBanksSaved.count > 0){
            for bank in arrayOfLatvianBanksSaved {
                if (!self.arrayOfLatviaRegionsStrings.contains(bank.r ?? "")) {
                    self.arrayOfLatviaRegionsStrings.append(bank.r ?? "")
                    let region: Region = Region(regionName: bank.r ?? "")
                    self.arrayOfLatviaRegions.append(region)
                }
            }
            self.arrayOfLatviaRegions = self.arrayOfLatviaRegions.sorted(by: {  $0.regionName ?? "" < $1.regionName ?? "" })
        } else {
            refreshLatvianBanks()
        }
    }
    
    func refreshLatvianBanks() {
        guard let urlLatvia = URL(string: apiUrlLatvia) else {return}
        URLSession.shared.dataTask(with: urlLatvia) { (data, resp, err) in
            DispatchQueue.main.async {
                self.setCookie(domain: ".swedbank.lv")
                self.banksLatvia = try! JSONDecoder().decode([BankLocation].self, from: data!)
                BanksViewModel.saveAllObjects(allObjects: self.banksLatvia, key: "SavedLatvianBanks")
                
                for bank in self.banksLatvia {
                    if (!self.arrayOfLatviaRegionsStrings.contains(bank.r ?? "")) {
                        self.arrayOfLatviaRegionsStrings.append(bank.r ?? "")
                        let region: Region = Region(regionName: bank.r ?? "")
                        self.arrayOfLatviaRegions.append(region)
                    }
                }
                self.arrayOfLatviaRegions = self.arrayOfLatviaRegions.sorted(by: {  $0.regionName ?? "" < $1.regionName ?? "" })
            }
        }.resume()
    }
    
    func fetchLithuaniaBanks(){
        var arrayOfLithuanianBanksSaved: [BankLocation] = []
        let defaults = UserDefaults.standard
        if let savedLithuanianBanks = defaults.object(forKey: "SavedLithuanianBanks") as? Data {
            arrayOfLithuanianBanksSaved = BanksViewModel.getAllLithuanianBanks
            self.banksLithuania = arrayOfLithuanianBanksSaved
        }
        
        if (arrayOfLithuanianBanksSaved.count > 0){
            for bank in arrayOfLithuanianBanksSaved {
                if (!self.arrayOfLithuaniaRegionsStrings.contains(bank.r ?? "")) {
                    self.arrayOfLithuaniaRegionsStrings.append(bank.r ?? "")
                    let region: Region = Region(regionName: bank.r ?? "")
                    self.arrayOfLithuaniaRegions.append(region)
                }
            }
            self.arrayOfLithuaniaRegions = self.arrayOfLithuaniaRegions.sorted(by: {  $0.regionName ?? "" < $1.regionName ?? "" })
        } else {
            refreshLithuaniaBanks()
        }
    }
    
    func refreshLithuaniaBanks(){
        guard let urlLithuania = URL(string: apiUrlLithuania) else {return}
              
        URLSession.shared.dataTask(with: urlLithuania) { (data, resp, err) in
            DispatchQueue.main.async {
                self.setCookie(domain: ".swedbank.lt")
                self.banksLithuania = try! JSONDecoder().decode([BankLocation].self, from: data!)
                BanksViewModel.saveAllObjects(allObjects: self.banksLithuania, key: "SavedLithuanianBanks")
                for bank in self.banksLithuania {
                    if (!self.arrayOfLithuaniaRegionsStrings.contains(bank.r ?? "")) {
                        self.arrayOfLithuaniaRegionsStrings.append(bank.r ?? "")
                        let region: Region = Region(regionName: bank.r ?? "")
                        self.arrayOfLithuaniaRegions.append(region)
                    }
                }
                
                self.arrayOfLithuaniaRegions = self.arrayOfLithuaniaRegions.sorted(by: {  $0.regionName ?? "" < $1.regionName ?? "" })
            }
        }.resume()
    }
    
    func setCookie(domain: String){
        if let cookie = HTTPCookie(properties: [
            .domain: domain,
            .path: "/",
            .name: "Swedbank-Embedded",
            .value: "iphone-app",
            .secure: "FALSE",
            .discard: "TRUE"
        ]) {
            HTTPCookieStorage.shared.setCookie(cookie)
            print("Cookie inserted: \(cookie)")
        }
    }
    
    func refreshAllBanks(){
        var mustRefresh: Bool = true
        if let dateLastDownload = UserDefaults.standard.object(forKey: "lastDownload") as? Date {
            let userCalendar = Calendar.current
            let requestedComponent: Set<Calendar.Component> = [.second]
            let startTime = dateLastDownload
            let endTime = Date()
            let timeDifference = userCalendar.dateComponents(requestedComponent, from: startTime, to: endTime)
            
            if let differenceInSeconds = timeDifference.second {
                if (differenceInSeconds < 3599){
                    mustRefresh = false
                }
            }
        }
        
        if (mustRefresh){
            refreshEstonianBanks()
            refreshLatvianBanks()
            refreshLithuaniaBanks()
            UserDefaults.standard.set(Date(), forKey: "lastDownload")
        } else {
            fetchEstonianBanks()
            fetchLatvianBanks()
            fetchLithuaniaBanks()
        }
    }
    
    func fetchAllBanks(){
        fetchEstonianBanks()
        fetchLatvianBanks()
        fetchLithuaniaBanks()
    }
}
