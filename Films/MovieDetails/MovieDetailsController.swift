//
//  MovieDetailsController.swift
//  Films
//
//  Created by Ксения Маричева on 26.12.2024.
//

import UIKit

class MovieDetailsController: UIViewController {
    
    // MARK: - naming
    
    var presenter: MovieDetailsOutput?
    
    private let id: Int
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
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
    
    private lazy var backView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .white
        view.image = UIImage(systemName: "arrowshape.backward.fill")
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(back)))
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        // tbd
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "Chalkboard SE", size: 20)
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - init
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        #warning("Добавила свайп назад")
        view.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(back)))
        
        presenter?.getDetails(by: id)
        setupView()
    }
    
    // MARK: - methods
    private func setupView() {
        
        view.backgroundColor = .black
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(posterImageView)
        contentView.addSubview(backView)
        contentView.addSubview(overviewLabel)
        
        let inset = CGFloat(16)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            posterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            posterImageView.heightAnchor.constraint(equalToConstant: 300),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 0.7),
            
            backView.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            backView.heightAnchor.constraint(equalToConstant: 25),
            backView.widthAnchor.constraint(equalTo: backView.heightAnchor),
            
            overviewLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: inset),
            overviewLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
}

    
extension MovieDetailsController: MovieDetailsInput {
    
    func configureWithDetails(_ movieDetails: MovieDetails) {
        overviewLabel.text = movieDetails.overview
    }
    
    func configureWithPoster(_ poster: UIImage) {
        posterImageView.image = poster
    }
}
