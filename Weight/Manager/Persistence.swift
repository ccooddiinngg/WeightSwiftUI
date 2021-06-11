//
//  Persistence.swift
//  Weight
//
//  Created by Hanjun Kang on 6/4/21.
//
import Foundation
import CoreData

class PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentCloudKitContainer

    let startDay = Date(timeIntervalSinceReferenceDate: 0)

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Weight")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })

        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    //MARK: - Func
    func add(weight: Float, date: Date, useMetric: Bool = false) {
        let entry = WeightRecord(context: container.viewContext)
        entry.id = UUID()
        entry.timestamp = date
        entry.date = dateFormatter.string(from: date)
        entry.metric = useMetric
        entry.weight = weight
        entry.days = Int64(Calendar.current.numberOfDaysBetween(startDay, and: date))

        do {
            try container.viewContext.save()
        } catch  {
            print(error)
        }
    }

    func fetch(by: ChartData) -> [WeightRecord] {
        []
    }

}
