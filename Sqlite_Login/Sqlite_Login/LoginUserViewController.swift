
import UIKit

class LoginUserViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtReenterPwd: UITextField!
   
    var arr : [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SetupTextfield()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        Getdata()
    }
    
    func Getdata()  {
        
        let query = "select * from Login"
        let db = DBClass()
        arr = db.GetData(query: query)
    }
    
    func SetupTextfield()  {
        
        let txtu_name_bottomlayer = CALayer()
        txtu_name_bottomlayer.frame = CGRect(x: 0, y: txtUsername.frame.size.height, width: txtUsername.frame.size.width, height: 1.0)
        txtu_name_bottomlayer.backgroundColor = UIColor.cyan.cgColor
        txtUsername.borderStyle = UITextBorderStyle.none
        txtUsername.layer.addSublayer(txtu_name_bottomlayer)
        
        let txtpwd_bottomlayer = CALayer()
        txtpwd_bottomlayer.frame = CGRect(x: 0, y: txtPassword.frame.size.height, width: txtPassword.frame.size.width, height: 1.0)
        txtpwd_bottomlayer.backgroundColor = UIColor.cyan.cgColor
        txtPassword.borderStyle = UITextBorderStyle.none
        txtPassword.layer.addSublayer(txtpwd_bottomlayer)
        
        let txtRetypepwd_bottomlayer = CALayer()
        txtRetypepwd_bottomlayer.frame = CGRect(x: 0, y: txtReenterPwd.frame.size.height, width: txtReenterPwd.frame.size.width, height: 1.0)
        txtRetypepwd_bottomlayer.backgroundColor = UIColor.cyan.cgColor
        txtReenterPwd.borderStyle = UITextBorderStyle.none
        txtReenterPwd.layer.addSublayer(txtRetypepwd_bottomlayer)
    }

    @IBAction func btnLogin(_ sender: Any) {
    
        for item in arr {
            
            let temp_arr = item as! [Any]
            let user_name_store = temp_arr[1] as! String
            let pwd_store = temp_arr[2] as! String
            
            if txtUsername.text == user_name_store && txtPassword.text == pwd_store {
                
                let alt = UIAlertController(title: "Thank you", message: "Verification successfully completed", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: {
                    
                    ACTION in
                    
                    print("Thank You")
                })
                
                alt.addAction(ok)
                self.present(alt, animated: true, completion: nil)
                //print("Success")
                break
            }
            else {
                
                print("Try again!")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
}
