
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblView: UITableView!
    
    //var arr : [String] = ["First","Second","Third","Forth"]
    var arr : [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Getdata()
    }
    override func viewWillAppear(_ animated: Bool) {
        Getdata()
    }
    
    func Getdata()  {
        
        let query = "select * from Login"
        let db = DBClass()
        arr = db.GetData(query: query)
        //print(arr)
        tblView.reloadData()
    }
    
    func Deletedata(id : String)  {
        
        let query = "delete from Login where u_id='\(id)'"
        let db = DBClass()
        let status = db.DML(query: query)
        if status == true {
            
            print("Deleted")
            Getdata()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return arr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let temp = arr[indexPath.section] as! [String]
        if indexPath.row == 0 {
            
            cell.textLabel?.text = temp[1]
        }
        if indexPath.row == 1 {
            
            cell.textLabel?.text = temp[2]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let story = self.storyboard?.instantiateViewController(withIdentifier: "UpdateUserViewController") as! UpdateUserViewController
        let temp = arr[indexPath.section] as! [String]
        story.id_store = temp[0]
        story.user_name_store = temp[1]
        story.password_store = temp[2]
        story.image_name_store = temp[3]
        self.navigationController?.pushViewController(story, animated: true)
    }
    
    @IBAction func barbuttonSelectUser(_ sender: UIBarButtonItem) {
    
        let alt = UIAlertController(title: "SELECT USER", message: "Kindly select specific user", preferredStyle: .alert)
        let new_user = UIAlertAction(title: "New User", style: .default) {
            
            ACTION in
            
            let story = self.storyboard?.instantiateViewController(withIdentifier: "InsertUserViewController") as! InsertUserViewController
            self.navigationController?.pushViewController(story, animated: true)
        }
        let existing_user = UIAlertAction(title: "Existing User", style: .default) {
            
            ACTION in
            
            let story = self.storyboard?.instantiateViewController(withIdentifier: "LoginUserViewController") as! LoginUserViewController
            self.navigationController?.pushViewController(story, animated: true)
        }
        alt.addAction(new_user)
        alt.addAction(existing_user)
        
        self.present(alt, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let temp = arr[indexPath.section] as! [String]
        let temp_id = temp[0]
        Deletedata(id: temp_id)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }


}

