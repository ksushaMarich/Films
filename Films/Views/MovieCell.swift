//
//  RespondTableViewCell.swift
//  Films
//
//  Created by Ксения Маричева on 03.12.2024.
//

import UIKit

protocol MovieCellDelegate: AnyObject {
    func didSelectMovie(_ movie: Movie)
}

class MovieCell: UITableViewCell {

    //MARK: - naming
    static let identifier = "MovieCell"
    
    weak var delegate: MovieCellDelegate?
    
    private var movie: Movie?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Chalkboard SE", size: 40)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellIsTapped))) //
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - methods
    private func setupView() {
        let inset = CGFloat(16)
        contentView.addSubview(titleLabel)
        contentView.addSubview(posterImageView)
        
        NSLayoutConstraint.activate([
            
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            posterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            posterImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: inset),
            posterImageView.heightAnchor.constraint(equalToConstant: 500),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 0.7),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
        ])
    }

    
    @objc func cellIsTapped() { //
        guard let movie else { return }
        delegate?.didSelectMovie(movie)
    }
    
    //MARK: - configuring cell method
    func configure(with movie: Movie) {
        self.movie = movie
        titleLabel.text = movie.title
        
        Task {
            posterImageView.image = try await NetworkManager.shared.downloadPoster(poster: movie.poster)    //
        }
    }
}
