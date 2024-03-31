//
//  PortfolioDataService.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/31/24.
//

import Foundation
import CoreData

class PortfolioDataService {
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error while loading core data \(error.localizedDescription)")
            }
            self.getPortfolio()
        }
    }
    
    func updatePortfolio(coin: Coin, amount: Double) {
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                updateEntity(entity: entity,
                             amount: amount)
            } else {
                deleteEntity(entity: entity)
            }
        } else {
            addEntity(coin: coin,
                      amount: amount)
        }
    }
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portfolio Entities: \(error.localizedDescription)")
        }
    }
    
    private func addEntity(coin: Coin, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func updateEntity(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func deleteEntity(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func saveEntity() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to CoreData: \(error.localizedDescription)")
        }
    }
    
    private func applyChanges() {
        saveEntity()
        getPortfolio()
    }
    
    
    
}
