//
//  ItemCollectionViewCell.swift
//  ControleDeGastos
//
//  Created by Gabriel Juren on 07/01/22.
//

import Foundation
import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: ItemCollectionViewCellDelegate?
    var isGoalReached: Bool = false
    
    private lazy var checkImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "checkmark.circle")!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.tintColor = .systemGreen
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var editImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "pencil")!)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.editItem))
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return imageView
    }()
    
    private lazy var trashImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "trash")!)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.removeItem))
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    private lazy var valorObjetivoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        return label
    }()
    
    private lazy var valorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.5)
        label.textColor = .black
        return label
    }()
    
    func setupViews() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        checkImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        checkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        
        valorLabel.translatesAutoresizingMaskIntoConstraints = false
        valorLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        valorLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        trashImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        trashImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
        editImageView.trailingAnchor.constraint(equalTo: trashImageView.leadingAnchor, constant: -5).isActive = true
        editImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
        valorObjetivoLabel.translatesAutoresizingMaskIntoConstraints = false
        valorObjetivoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        valorObjetivoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(nameLabel)
        contentView.addSubview(valorLabel)
        contentView.addSubview(editImageView)
        contentView.addSubview(trashImageView)
        contentView.addSubview(valorObjetivoLabel)
        contentView.addSubview(checkImageView)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure (with model: ItemModel) {
        nameLabel.text = model.Nome
        valorLabel.text = "R$ \(String(model.Valor))"
        valorObjetivoLabel.text = "R$ \(String(model.ValorObjetivo))"
        
        if model.IsGoalReached {
            var historicModel = HistoricModel(Id: 0, Nome: "", Valor: 0, ValorObjetivo: 0, DataFinalizado: Date())
            historicModel.Nome = model.Nome
            historicModel.Valor = model.Valor
            historicModel.ValorObjetivo = model.ValorObjetivo
        }
        
        setComponentsStyle(model: model)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.borderColor = isGoalReached ? UIColor.systemGreen.cgColor : UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 8
    }
    
    @objc func removeItem() {
        delegate?.removeItem(cell: self)
    }
    
    @objc func editItem() {
        delegate?.editItem(cell: self)
    }
    
    func setComponentsStyle(model: ItemModel) {
        valorObjetivoLabel.textColor = model.IsGoalReached ? .lightGray : .black
        valorLabel.textColor = model.IsGoalReached ? .lightGray : .black
        nameLabel.textColor = model.IsGoalReached ? .lightGray : .black
        editImageView.tintColor = model.IsGoalReached ? .systemGreen : .systemBlue
        trashImageView.tintColor = model.IsGoalReached ? .systemGreen : .systemBlue
        checkImageView.isHidden = !model.IsGoalReached
        isGoalReached = model.IsGoalReached
    }
}
