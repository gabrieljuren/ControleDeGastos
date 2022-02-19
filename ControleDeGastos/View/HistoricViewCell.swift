//
//  HistoricViewCell.swift
//  ControleDeGastos
//
//  Created by Gabriel Juren on 12/01/22.
//

import Foundation
import UIKit

class HistoricViewCell: UITableViewCell {
    
    static var identifier = "historicViewCell"
    var dbHelper = Helper()
        
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 19)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var valorObjetivoLabelHeader: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var valorObjetivoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.5)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var valorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.5)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dataConcluidoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.5)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Data Concluído: "
        return label
    }()
    
    private lazy var valorObjetivoLabelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16.5)
        label.textColor = .black
        label.text = "Objetivo: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var valorLabelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16.5)
        label.textColor = .black
        label.text = "Valor: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dataConcluidoLabelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16.5)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Data Concluído: "
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "historicViewCell")
        contentView.addSubview(nameLabel)
        contentView.addSubview(valorLabel)
        contentView.addSubview(valorObjetivoLabel)
        contentView.addSubview(dataConcluidoLabel)
        contentView.addSubview(valorObjetivoLabelTitle)
        contentView.addSubview(valorLabelTitle)
        contentView.addSubview(dataConcluidoLabelTitle)
        contentView.addSubview(valorObjetivoLabelHeader)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure (with model: HistoricModel) {
        nameLabel.text = model.Nome
        valorLabel.text = String("R$\(model.Valor)")
        valorObjetivoLabel.text = String("R$\(model.ValorObjetivo)")
        dataConcluidoLabel.text = dbHelper.DateToString(dateParametter: model.DataFinalizado)
    }
    
    func setLayout() {
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        valorLabelTitle.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        valorLabelTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        valorLabelTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        valorLabel.topAnchor.constraint(equalTo: valorLabelTitle.topAnchor).isActive = true
        valorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60).isActive = true
        
        valorObjetivoLabelTitle.topAnchor.constraint(equalTo: valorLabel.bottomAnchor, constant: 5).isActive = true
        valorObjetivoLabelTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        valorObjetivoLabelTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        valorObjetivoLabel.topAnchor.constraint(equalTo: valorObjetivoLabelTitle.topAnchor).isActive = true
        valorObjetivoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 85).isActive = true
        
        dataConcluidoLabelTitle.topAnchor.constraint(equalTo: valorObjetivoLabel.bottomAnchor, constant: 5).isActive = true
        dataConcluidoLabelTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        dataConcluidoLabelTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        dataConcluidoLabel.topAnchor.constraint(equalTo: dataConcluidoLabelTitle.topAnchor).isActive = true
        dataConcluidoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 140).isActive = true
    }
}
