
import UIKit

class DBClass: NSObject {

    func DML(query : String) -> Bool {
        
        var status : Bool = false
        
        let arr = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let path = arr[0]
        
        let fullpath = path.appending("/Registration.db")
        
        print(fullpath)
        
        var dbop : OpaquePointer? = nil
        
        if sqlite3_open(fullpath, &dbop) == SQLITE_OK {
            
            var stmt : OpaquePointer? = nil
            
            if sqlite3_prepare_v2(dbop, query, -1, &stmt, nil) == SQLITE_OK {
                
                sqlite3_step(stmt)
                
                status = true
                
                sqlite3_finalize(stmt)
            }
            
            sqlite3_close(dbop)
        }
        
        return status
    }
    
    func GetData(query : String) -> [Any] {
        
        var arr_main : [Any] = []
        
        var status : Bool = false
        
        let arr = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let path = arr[0]
        
        let fullpath = path.appending("/Registration.db")
        
        print(fullpath)
        
        var dbop : OpaquePointer? = nil
        
        if sqlite3_open(fullpath, &dbop) == SQLITE_OK {
            
            var stmt : OpaquePointer? = nil
            
            if sqlite3_prepare_v2(dbop, query, -1, &stmt, nil) == SQLITE_OK {
                
                while sqlite3_step(stmt) == SQLITE_ROW {
                    
                    var temp : [String] = []
                    
                    let u_id = String(cString: sqlite3_column_text(stmt, 0))
                    let user_name = String(cString: sqlite3_column_text(stmt, 1))
                    let password = String(cString: sqlite3_column_text(stmt, 2))
                    let image_name = String(cString: sqlite3_column_text(stmt, 3))
                    
                    temp.append(u_id)
                    temp.append(user_name)
                    temp.append(password)
                    temp.append(image_name)
                    
                    arr_main.append(temp)
                }
                
                status = true
                
                sqlite3_finalize(stmt)
            }
            
            sqlite3_close(dbop)
        }
        
        return arr_main
    }

}
