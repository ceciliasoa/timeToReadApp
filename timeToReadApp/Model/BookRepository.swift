//
//  BookRepository.swift
//  timeToReadApp
//
//  Created by Cecilia Soares on 09/02/21.
//

import Foundation
import UIKit
import CoreData

class BookRepository {
    func getContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        return managedContext
    }
    
    func create(book: BookModel) {
        guard let context = getContext(),
              let entity = NSEntityDescription.entity(forEntityName: "BookEntity", in: context)
        else { return }
        
        let bookSave = NSManagedObject(entity: entity, insertInto: context)
        bookSave.setValue(book.title, forKey: "title")
        bookSave.setValue(book.author, forKey: "author")
        bookSave.setValue(book.pages, forKey: "pages")
        bookSave.setValue(book.cover, forKey: "cover")
        bookSave.setValue(book.readpages, forKey: "readpages")
        bookSave.setValue(book.percentage, forKey: "percentage")
        bookSave.setValue(book.status, forKey: "status")
        do {
            try context.save()
        } catch let error as NSError {
            print("could not save \(error) \(error.userInfo)")
        }
    }
//    func loadData(table: UITableView) {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BookEntity")
//        guard let context = getContext() else { return }
//        var books = [NSManagedObject]()
//        do {
//            let results = try context.fetch(fetchRequest)
//            books = results as! [NSManagedObject]
////            items.append(contentsOf: name)
//            
//        } catch {
//            fatalError("Error is retriving titles items")
//        }
//        table.reloadData()
//    }
    func readAll() -> [NSManagedObject] {
        var books = [NSManagedObject]()
        guard let context = getContext() else { return [] }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "BookEntity")
        
        do {
            books = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not read. \(error), \(error.userInfo)")
        }
        
        return books
    }
    
    func readCurrent() -> NSManagedObject? {
        guard let context = getContext() else { return nil }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "BookEntity")
//        fetchRequest.predicate = NSPredicate(format: "isCurrent == %@", "true")
        
        do {
            let bookFetch = try context.fetch(fetchRequest)
            guard !bookFetch.isEmpty,
                  let bookManagedObject = bookFetch.first else { return nil }
            
            return bookManagedObject
        } catch let error as NSError {
            print("Could not read. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    @discardableResult
    func remove(book: NSManagedObject) -> Bool {
        guard let context = getContext() else { return false }
        context.delete(book)
        do {
            try context.save()
            return true
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func update(book: BookModel) {
        guard let context = getContext() else { return }
  
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "BookEntity")
        
        do {
            let booksFetch = try context.fetch(fetchRequest)
            let bookUpdate = booksFetch[0] as NSManagedObject
            bookUpdate.setValue(book.title, forKey: "title")
            bookUpdate.setValue(book.author, forKey: "author")
            bookUpdate.setValue(book.pages, forKey: "pages")
            bookUpdate.setValue(book.cover, forKey: "cover")
            bookUpdate.setValue(book.readpages, forKey: "readpages")
            bookUpdate.setValue(book.percentage, forKey: "percentage")
            bookUpdate.setValue(book.status, forKey: "status")
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not update. \(error), \(error.userInfo)")
            }
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
    }
}
