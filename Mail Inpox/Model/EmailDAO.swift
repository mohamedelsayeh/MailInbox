import Foundation
import CoreData

class EmailDAO  {
    
    var managedObjectContext : NSManagedObjectContext!
    
    init(managedObjectContext : NSManagedObjectContext){
        self.managedObjectContext = managedObjectContext
    }
    
    
    func save(email : Email) -> Email!{
        
        let managedEmail = NSEntityDescription.insertNewObjectForEntityForName("Email", inManagedObjectContext: self.managedObjectContext!) as! Email
        
        managedEmail.from = email.from
        managedEmail.time = email.time
        managedEmail.header = email.header
        managedEmail.content = email.content
        managedEmail.isRead = email.isRead

        do {
            try managedObjectContext.save()
            print("saved")
        }
        catch let error {
            print(error)
        }
        return email;
    }
    
    func save(emailsList : [Email]) {
        deleteAll()
        for email in emailsList {
            save(email)
        }
    }
    
    func deleteAll() {
        let fetchRequest = NSFetchRequest(entityName: "Email")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            let result = try managedObjectContext.executeRequest(deleteRequest)
            print(result)
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    func selectAll() -> [Email]{
        let fetched = NSFetchRequest(entityName : "Email")
        var res : [Email]!
        do {
            res = try managedObjectContext.executeFetchRequest(fetched) as! [Email]
        } catch let error {
            print(error)
        }
        return res
    }
    
    func markAsRead(email : Email) {
        email.isRead = true
        do {
            try managedObjectContext.save()
            print("saved")
        }
        catch let error {
            print(error)
        }
    }
}