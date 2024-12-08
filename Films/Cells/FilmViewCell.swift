//
//  RespondTableViewCell.swift
//  Films
//
//  Created by Ксения Маричева on 03.12.2024.
//

import UIKit

class FilmViewCell: UITableViewCell {

    //MARK: - naming
    static let identifier = "FilmViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .red
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setup view method
    private func setupView() {
        let inset = CGFloat(16)
        contentView.addSubview(titleLabel)
        contentView.addSubview(posterImageView)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            posterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: inset),
            posterImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: inset),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 200),
            
        ])
    }
    
    //MARK: - configuring cell method
    func configuring(movie: Movie, posers: UIImage) {
        titleLabel.text = movie.title
        posterImageView.image = posers
    }
}
