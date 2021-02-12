//
//  BookDescription.swift
//  timeToReadApp
//
//  Created by Cecilia Soares on 11/02/21.
//
// swiftlint:disable line_length

import UIKit

class BookDescription: UIView {
    // MARK: - Elements
    lazy var cover: UIImageView = {
        let cover = UIImageView()
        cover.sizeToFit()
        cover.layer.bounds.size.width = 109
        print(cover.layer.bounds.size.width)
        cover.layer.bounds.size.height = 154
        cover.backgroundColor = .backgroundSecundary
        
        cover.translatesAutoresizingMaskIntoConstraints = false
        return cover
    }()
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 18, weight: .semibold)
        title.tintColor = .textColor
        title.translatesAutoresizingMaskIntoConstraints = false
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = .max
        return title
    }()
    lazy var author: UILabel = {
        let author = UILabel()
        author.font = .systemFont(ofSize: 14, weight: .light)
        author.tintColor = .textColor
        author.translatesAutoresizingMaskIntoConstraints = false
        author.lineBreakMode = .byWordWrapping
        author.numberOfLines = .max
        return author
    }()
    lazy var pages: UILabel = {
        let pages = UILabel()
        pages.font = .systemFont(ofSize: 14, weight: .light)
        pages.tintColor = .textColor
        pages.translatesAutoresizingMaskIntoConstraints = false
        return pages
    }()
    lazy var status: UIButton = {
        let status = UIButton()
        status.layer.bounds.size.width = 49
        status.layer.bounds.size.height = 23
        status.translatesAutoresizingMaskIntoConstraints = false
        status.backgroundColor = .actionColor
        status.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        status.setTitle("Lendo", for: .normal)
        status.setTitleColor(.textButtonsColor, for: .normal)
        return status
    }()
    lazy var update: UIButton = {
        let update = UIButton()
        update.layer.bounds.size.width = UIScreen.main.bounds.width / 2
        update.layer.bounds.size.height = 30
        update.translatesAutoresizingMaskIntoConstraints = false
        update.backgroundColor = .actionColor
        update.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        update.setTitle("Atualizar leitura", for: .normal)
        update.setTitleColor(.textButtonsColor, for: .normal)
        return update
    }()
    lazy var detail: UIButton = {
        let detail = UIButton()
        detail.layer.bounds.size.width = UIScreen.main.bounds.width / 2
        detail.layer.bounds.size.height = 30
        detail.translatesAutoresizingMaskIntoConstraints = false
        detail.backgroundColor = .actionColor
        detail.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        detail.setTitle("Detalhes", for: .normal)
        detail.setTitleColor(.textButtonsColor, for: .normal)
        return detail
    }()
    lazy var synopsis: UILabel = {
        let synopsis = UILabel()
        synopsis.font = .systemFont(ofSize: 18, weight: .medium)
        synopsis.tintColor = .textColor
        synopsis.translatesAutoresizingMaskIntoConstraints = false
        synopsis.text = "Sinopse"
        
        return synopsis
    }()
    lazy var synopsisText: UILabel = {
        let synopsisText = UILabel()
        synopsisText.font = .systemFont(ofSize: 18, weight: .medium)
        synopsisText.tintColor = .textColor
        synopsisText.translatesAutoresizingMaskIntoConstraints = false
        
        return synopsisText
    }()
    lazy var progress: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .bar)
        progress.center = self.center
        progress.setProgress(0.5, animated: true)
        progress.trackTintColor = .disabledColor
        progress.tintColor = .actionColor
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    lazy var readPages: UIStackView = {
        let readPages = UIStackView()
        return readPages
    }()
    lazy var descriptionBook: UITableView = {
        let descriptionBook = UITableView()
        descriptionBook.layer.bounds.size.width = UIScreen.main.bounds.width - 40
        descriptionBook.translatesAutoresizingMaskIntoConstraints = false
        descriptionBook.backgroundColor = .backgroundSecundary
        descriptionBook.separatorStyle = .none
        descriptionBook.showsVerticalScrollIndicator = false
        return descriptionBook
    }()
    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = .backgroundColor
        setupViewHierarchy()
        setupCover()
        setupTitle()
        setupAuthor()
        setupPages()
        setupStatus()
        setupUpdate()
        setupDetail()
        setupSynopsis()
        setupDescription()
        setupProgress()
        
    }
    
    // MARK: - Functions
    func setupViewHierarchy() {
        addSubview(cover)
        addSubview(title)
        addSubview(author)
        addSubview(pages)
        addSubview(status)
        addSubview(progress)
        addSubview(update)
        addSubview(detail)
        addSubview(synopsis)
        addSubview(descriptionBook)
    }
    func setupCover() {
        NSLayoutConstraint.activate([
            cover.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -40),
            cover.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            cover.widthAnchor.constraint(equalToConstant: cover.layer.bounds.width),
            cover.heightAnchor.constraint(equalToConstant: cover.layer.bounds.height)
        ])
    }
    func setupTitle() {
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: cover.trailingAnchor, constant: 20),
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

//            title.widthAnchor.constraint(equalTo: title.widthAnchor),
            title.heightAnchor.constraint(equalTo: title.heightAnchor)
        ])
    }

    func setupAuthor() {
        NSLayoutConstraint.activate([
            author.leadingAnchor.constraint(equalTo: cover.trailingAnchor, constant: 20),

//            author.centerXAnchor.constraint(equalTo: centerXAnchor),
            author.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            author.widthAnchor.constraint(equalTo: author.widthAnchor),
            author.heightAnchor.constraint(equalTo: author.heightAnchor)
        ])
    }
    func setupPages() {
        NSLayoutConstraint.activate([
            pages.leadingAnchor.constraint(equalTo: cover.trailingAnchor, constant: 20),
            pages.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 5),
            pages.widthAnchor.constraint(equalTo: pages.widthAnchor),
            pages.heightAnchor.constraint(equalTo: pages.heightAnchor)
        ])
    }
    func setupStatus() {
        NSLayoutConstraint.activate([
            status.leadingAnchor.constraint(equalTo: cover.trailingAnchor, constant: 20),
            status.topAnchor.constraint(equalTo: pages.bottomAnchor, constant: 10),
            status.widthAnchor.constraint(equalToConstant: status.layer.bounds.width),
            status.heightAnchor.constraint(equalToConstant: status.layer.bounds.height)
        ])
    }
    func setupUpdate() {
        NSLayoutConstraint.activate([
            update.leadingAnchor.constraint(equalTo: leadingAnchor),
            update.topAnchor.constraint(equalTo: progress.bottomAnchor, constant: 40),
            update.widthAnchor.constraint(equalToConstant: update.layer.bounds.size.width),
            update.heightAnchor.constraint(equalToConstant: update.layer.bounds.height)
        ])
    }
    func setupDetail() {
        NSLayoutConstraint.activate([
            detail.leadingAnchor.constraint(equalTo: update.trailingAnchor),
            detail.topAnchor.constraint(equalTo: progress.bottomAnchor, constant: 40),
            detail.widthAnchor.constraint(equalToConstant: detail.layer.bounds.size.width),
            detail.heightAnchor.constraint(equalToConstant: detail.layer.bounds.height)
        ])
    }
    func setupSynopsis() {
        NSLayoutConstraint.activate([
            synopsis.centerXAnchor.constraint(equalTo: centerXAnchor),
            synopsis.topAnchor.constraint(equalTo: update.bottomAnchor, constant: 10),
            synopsis.widthAnchor.constraint(equalTo: synopsis.widthAnchor),
            synopsis.heightAnchor.constraint(equalTo: synopsis.heightAnchor)
        ])
    }
    func setupDescription() {
        NSLayoutConstraint.activate([
            descriptionBook.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionBook.topAnchor.constraint(equalTo: synopsis.bottomAnchor, constant: 10),
            descriptionBook.widthAnchor.constraint(equalToConstant: descriptionBook.layer.bounds.width),
//            descriptionBook.heightAnchor.constraint(equalToConstant: descriptionBook.layer.bounds.height),

            descriptionBook.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])
    }
    func setupProgress() {
        NSLayoutConstraint.activate([
            progress.leadingAnchor.constraint(equalTo: cover.trailingAnchor, constant: 20),
            progress.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            progress.topAnchor.constraint(equalTo: status.bottomAnchor, constant: 20),
//            progress.widthAnchor.constraint(equalToConstant: progress.layer.bounds.width),
            progress.heightAnchor.constraint(equalToConstant: progress.layer.bounds.height)

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
