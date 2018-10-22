
import UIKit

class UpdateUserViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtReenterPwd: UITextField!

    var id_store : String = ""
    var user_name_store : String = ""
    var password_store : String = ""
    var image_name_store : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtUsername.text = user_name_store
        txtPassword.text = password_store
        let decodedata = NSData(base64Encoded: image_name_store, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
        imgProfile.image = UIImage(data: decodedata as! Data)
        SetupTextfield()
    }
    
    func Cleardata()  {
        
        txtUsername.text = ""
        txtPassword.text = ""
        txtReenterPwd.text = ""
        imgProfile.image = UIImage(named: "if_38_Target_Audience_1688838.png")
        txtUsername.becomeFirstResponder()
    }
    func Updatedata(id : String)  {
        
        let data = UIImagePNGRepresentation(imgProfile.image!)
        let basestr = data?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        let query = "update Login set user_name='\(txtUsername.text!)',password='\(txtPassword.text!)',image_name='\(basestr!)' where u_id='\(id)'"
        let db = DBClass()
        let status = db.DML(query: query)
        if status == true {
            
            print("Updated")
            Cleardata()
        }
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
        
        imgProfile.clipsToBounds = true
        imgProfile.layer.cornerRadius = 50
    }
    
    @IBAction func btnSelectPhoto(_ sender: Any) {
    
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        imgProfile.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func btnUpdate(_ sender: Any) {
    
        Updatedata(id: id_store)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}
