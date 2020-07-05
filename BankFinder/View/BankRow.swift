//
//  BankRow.swift
//  BankFinder
//
//  Created by Mike Camara on 23/6/20.
//  Copyright © 2020 Mike Camara. All rights reserved.
//

import SwiftUI

struct BankRow: View {
    var bank: BankLocation
    
    func getTypeInitialsBankLocation(type: Int) -> String {
        var typeString: String
        switch type {
            case 0:
                typeString = "BR"
            case 1:
                typeString = "AT"
            case 2:
                typeString = "BN"
            default:
                typeString = ""
        }
        return typeString
    }
    
    func getTypeBankLocationColor(type: Int) -> Color {
        var color: Color
            switch type {
                case 0:
                    color = .blue
                case 1:
                    color = .yellow
                case 2:
                    color = .green
                default:
                    color = .blue
            }
            return color
    }
    
    var body: some View {
        HStack{
            VStack{
                Text(getTypeInitialsBankLocation(type: bank.t!)).font(.headline).foregroundColor(.white)
                    .background(Circle()
                        .fill(getTypeBankLocationColor(type: bank.t!))
                        .frame(width: 35, height: 35))
                    .padding(.trailing)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("\(bank.n!)").foregroundColor(.primary).font(.headline)
                Text("\(bank.a!)").foregroundColor(.secondary).font(.subheadline)
            }
        }
    }
}
