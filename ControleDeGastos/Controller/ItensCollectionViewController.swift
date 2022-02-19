//
//  ItensCollectionViewController.swift
//  ControleDeGastos
//
//  Created by Gabriel Juren on 30/12/21.
//

import Foundation
import UIKit

class ItensCollectionViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var items = [ItemModel]()
    var alertHelper = AlertHelper()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        //stack.layer.borderColor = UIColor.lightGray.cgColor
        //stack.layer.borderWidth = 0.5
        return stack
    }()
    
    private lazy var valorTotalLabelHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 15)
        label.textColor = .black
        label.text = "Total"
        return label
    }()
    
    private lazy var valorTotalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 14)
        label.textColor = .black
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 2
        flowLayout.itemSize = CGSize(width:(view.frame.size.width - 50)/2,
                                     height: 120)
        
        let collectionView = UICollectionView(frame : .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemCollectionViewCell.self,
                                forCellWithReuseIdentifier: "cellId")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(valorTotalLabelHeader)
        stackView.addArrangedSubview(valorTotalLabel)
        
        view.backgroundColor = .white
        title = "Itens"
        setLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ItemCollectionViewCell
        
        var model = items[indexPath.row]
        model.IsGoalReached = model.Valor >= model.ValorObjetivo && model.Valor > 0
        
        cell.configure(with: model)
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func setLayout() {
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        valorTotalLabelHeader.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20).isActive = true
        
        valorTotalLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5).isActive = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -5).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadItems()
    }
}

extension ItensCollectionViewController: ItemCollectionViewCellDelegate {
    
    func removeItem(cell: ItemCollectionViewCell) {
        
        if let indexPath = collectionView.indexPath(for: cell) {
            
            let alert = alertHelper.popupAlertHeader(title: "Atenção", message: "Deseja deletar o item \(items[indexPath.row].Nome)?")
            
            let cancelAction = UIAlertAction(title: "Não", style: .destructive)
            let confirmAction = UIAlertAction(
                title: "Sim", style: .default) { (action) in
                    
                    var historicItem = HistoricModel(Id: 0, Nome: "", Valor: 0, ValorObjetivo: 0, DataFinalizado: Date())
                    let model = self.items[indexPath.row]
                    
                    historicItem.ValorObjetivo = model.ValorObjetivo
                    historicItem.Valor = model.Valor
                    historicItem.Nome = model.Nome
                    HistoricDAO.Insert(with: historicItem)
                    
                    ItemsDAO.DeleteItem(Id: self.items[indexPath.row].Id)
                    self.reloadItems()
                }
            
            alert.addAction(cancelAction)
            alert.addAction(confirmAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    func editItem(cell: ItemCollectionViewCell) {
        
        if let indexPath = collectionView.indexPath(for: cell) {
            
            var model = self.items[indexPath.row]
            let alert = alertHelper.popupAlertHeader(title: "", message: "")
            
            alert.title = "Atualizar Item"
            alert.addTextField(configurationHandler: { (tf) in tf.text = model.Nome})
            alert.addTextField(configurationHandler: { (tf) in tf.text = String(model.Valor) })
            alert.addTextField(configurationHandler: { (tf) in tf.text = String(model.ValorObjetivo) })
            
            let action = UIAlertAction(title: "Salvar", style: .default) { (_) in
                guard let nome = alert.textFields?.first?.text,
                      let valor = alert.textFields?[1].text,
                      let valorObjetivo = alert.textFields?.last?.text
                else {
                    return
                }
                
                model.Nome = nome
                model.Valor = Double(valor)!
                model.ValorObjetivo = Double(valorObjetivo)!
                
                ItemsDAO.Update(with: model)
                self.reloadItems()
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func reloadItems() {
        items = ItemsDAO.SelectAll() as! [ItemModel]
        collectionView.reloadData()
        totalCalculation()
    }
    
    func totalCalculation() {
        var sum: Double = 0
        
        for val in items {
            sum += val.Valor
        }
        
        valorTotalLabel.text = "R$ \(String(sum))"
    }
}
