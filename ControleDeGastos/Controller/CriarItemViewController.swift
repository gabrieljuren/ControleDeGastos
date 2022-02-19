//
//  CriarItemViewController.swift
//  ControleDeGastos
//
//  Created by Gabriel Juren on 30/12/21.
//

import Foundation
import UIKit

class CriarItemViewController : UIViewController, UITextFieldDelegate {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    private lazy var moneyImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "dollarsign.square")!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        //imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var labelHeader: UILabel = {
        let label = UILabel()
        label.text = "Cadastre o Item desejado"
        label.textColor = .lightGray
        label.font = UIFont(name:"Avenir-Light", size: 25)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelNomeItem: UILabel = {
        let label = UILabel()
        label.text = "Item"
        label.textColor = .black
        label.font = UIFont(name:"Verdana", size: 13.5)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelValorItem: UILabel = {
        let label = UILabel()
        label.text = "Valor Atual"
        label.textColor = .black
        label.font = UIFont(name:"Verdana", size: 13.5)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var txtNomeItem: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.font = UIFont(name: "Avenir", size: 17.5)
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 0.5

        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5, height: 1.5))
        textField.leftView = leftView
        textField.leftViewMode = .always

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 35).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        return textField
    }()
    
    private lazy var txtValorItem: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.font = UIFont(name: "Avenir", size: 17.5)
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 0.5
        textField.keyboardType = .numberPad

        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5, height: 1.5))
        textField.leftView = leftView
        textField.leftViewMode = .always

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 35).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        return textField
    }()
    
    private lazy var txtValorObjetivo: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.font = UIFont(name: "Avenir", size: 17.5)
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 0.5
        textField.keyboardType = .numberPad

        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5, height: 1.5))
        textField.leftView = leftView
        textField.leftViewMode = .always

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 35).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        return textField
    }()
    
    private lazy var labelValorObjetivo: UILabel = {
        let label = UILabel()
        label.text = "Valor Final (Objetivo)"
        label.textColor = .black
        label.font = UIFont(name:"Verdana", size: 13.5)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Cadastrar", for: .normal)
        button.setTitleColor(UIColor.init(white: 1, alpha: 0.3), for: .highlighted)
        button.backgroundColor = .systemBlue
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.addTarget(self, action: #selector(CriarItemAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        view.addSubview(button)
        view.addSubview(txtNomeItem)
        view.addSubview(txtValorItem)
        view.addSubview(labelNomeItem)
        view.addSubview(labelValorItem)
        view.addSubview(labelHeader)
        view.addSubview(txtValorObjetivo)
        view.addSubview(labelValorObjetivo)
        view.addSubview(moneyImageView)
        
        setLayout()
    }
    
    func setLayout() {
        view.backgroundColor = .white
        title = "Criar Item"
        
        moneyImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        //moneyImageView.bottomAnchor.constraint(equalTo: labelNomeItem.topAnchor, constant: -80).isActive = true
        moneyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        labelHeader.bottomAnchor.constraint(equalTo: moneyImageView.bottomAnchor, constant: 40).isActive = true
        labelHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        txtNomeItem.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        txtNomeItem.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        txtNomeItem.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        txtNomeItem.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        labelNomeItem.topAnchor.constraint(equalTo: txtNomeItem.topAnchor, constant: -30).isActive = true
        labelNomeItem.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        
        txtValorItem.topAnchor.constraint(equalTo: txtNomeItem.bottomAnchor, constant: 45).isActive = true
        txtValorItem.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        txtValorItem.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        labelValorItem.topAnchor.constraint(equalTo: txtValorItem.topAnchor, constant: -30).isActive = true
        labelValorItem.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        
        labelValorObjetivo.topAnchor.constraint(equalTo: txtValorItem.bottomAnchor, constant: 15).isActive = true
        labelValorObjetivo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        
        txtValorObjetivo.topAnchor.constraint(equalTo: labelValorObjetivo.bottomAnchor, constant: 10).isActive = true
        txtValorObjetivo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        txtValorObjetivo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        button.topAnchor.constraint(equalTo: txtValorObjetivo.bottomAnchor, constant: 20).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func dismissKeyboard() {
        txtNomeItem.resignFirstResponder()
        txtValorItem.resignFirstResponder()
        txtValorObjetivo.resignFirstResponder()
    }
    
    @objc func CriarItemAction() {
        var model = ItemModel(Id: 0, Nome: "", Valor: 0, ValorObjetivo: 0, IsGoalReached: false)
        
        guard let nomeItem = txtNomeItem.text,
              let valorItem = txtValorItem.text,
              let valorObjetivo = txtValorObjetivo.text
        else { return }
        
        if nomeItem.isEmpty || valorItem.isEmpty || valorObjetivo.isEmpty{
            let alert = AlertHelper.popupAlert(title: "Atenção", message: "Os campos devem ser preenchidos.")
            present(alert, animated: true, completion: nil)
            return
        }
        
        model.Valor = Double(valorItem)!
        model.Nome = nomeItem
        model.ValorObjetivo = Double(valorObjetivo)!
        
        ItemsDAO.Insert(with: model)
        
        let uiAlert = AlertHelper.popupAlert(title: "Atenção", message: "Item criado com sucesso.")
        self.present(uiAlert, animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
