
import UIKit

class InsertUserViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    
        SetupTextfield()
    }
    
    func Insertdata()  {
        
        let imgData = UIImagePNGRepresentation(imgProfile.image!)
        let bssestr = imgData?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        
        let query = "insert into Login(user_name,password,image_name)values('\(txtUsername.text!)','\(txtPassword.text!)','\(bssestr!)')"
        let db = DBClass()
        let status = db.DML(query: query)
        if status == true {
            
            print("Inserted!")
            Cleardata()
        }
    }
    
    func Cleardata()  {
        
        txtUsername.text = ""
        txtPassword.text = ""
        imgProfile.image = UIImage(named: "if_38_Target_Audience_1688838.png")
        txtUsername.becomeFirstResponder()
    }
    
    func SetupTextfield()  {
        
        txtUsername.leftViewMode = .always
        let imgview_uname = UIImageView(image: UIImage(named:"if_Username_372902.png"))
        txtUsername.leftView = imgview_uname
        
        txtPassword.leftViewMode = .always
        let imgview_pwd = UIImageView(image: UIImage(named:"if_key_115724.png"))
        txtPassword.leftView = imgview_pwd
        
        let txtu_name_bottomlayer = CALayer()
        txtu_name_bottomlayer.frame = CGRect(x: 1, y: txtUsername.frame.size.height, width: txtUsername.frame.size.width, height: 1.0)
        txtu_name_bottomlayer.backgroundColor = UIColor.cyan.cgColor
        txtUsername.borderStyle = UITextBorderStyle.none
        txtUsername.layer.addSublayer(txtu_name_bottomlayer)
        
        let txtpwd_bottomlayer = CALayer()
        txtpwd_bottomlayer.frame = CGRect(x: 1, y: txtPassword.frame.size.height, width: txtPassword.frame.size.width, height: 1.0)
        txtpwd_bottomlayer.backgroundColor = UIColor.cyan.cgColor
        txtPassword.borderStyle = UITextBorderStyle.none
        txtPassword.layer.addSublayer(txtpwd_bottomlayer)
        
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

    @IBAction func btnCreateUser(_ sender: Any) {
    
        if txtUsername.text != "" && txtPassword.text != "" {
            
            Insertdata()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}
