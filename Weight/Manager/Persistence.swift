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

    func fetchLastRecords(with days: Int) -> [WeightRecord] {
        let today = Calendar.current.numberOfDaysBetween(startDay, and: Date())
        let from = today - days + 1
        let fetchRequest = NSFetchRequest<WeightRecord>(entityName: "WeightRecord")

        let results = from...today
        return results.map {days in
            fetchRequest.predicate = NSPredicate(format: "days == %i", days)
            if let record = try? container.viewContext.fetch(fetchRequest).first {
                return record
            }
            let record = WeightRecord(context: container.viewContext)
            record.id = UUID()
            record.timestamp = startDay.addingTimeInterval(TimeInterval(60 * 60 * 24 * days))
            return record
        }
    }

    func fetchRecordOn(days: Int) -> WeightRecord? {
        let fetchRequest = NSFetchRequest<WeightRecord>(entityName: "WeightRecord")
        fetchRequest.predicate = NSPredicate(format: "days == %i", days)

        do {
            let record = try container.viewContext.fetch(fetchRequest)
            return record.first
        } catch {
            print(error)
            return nil
        }
    }

    func fetchRecordOn(date: Date) -> WeightRecord? {
        let days = Calendar.current.numberOfDaysBetween(startDay, and: date)

        return fetchRecordOn(days: days)
    }

}
