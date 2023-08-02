//
//  ViewController.swift
//  SurfTest
//
//  Created by Дарья Леонова on 02.08.2023.
//

import UIKit

enum Section: CaseIterable {
    case photo
    case skills
    case about
}

class DataSource: NSObject, UICollectionViewDataSource {

    private var skills = ["MVI/MVVM", "Kotlin Coroutines", "Room", "DataSource", "SOLID", "VIPER", "WorkManager"]

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        skills.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkillCollectionViewCell", for: indexPath) as! SkillCollectionViewCell
        cell.configure(title: skills[indexPath.row])
        return cell
    }

}

class SkillCollectionViewCell: UICollectionViewCell {

    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    func configure(title: String) {
        label.text = title
        label.sizeToFit()
    }

    private func setup() {
        backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.961, alpha: 1)
        layer.cornerRadius = 10

        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }

}

class ViewController: UIViewController {

    private let dataSource = DataSource()

    private lazy var collectionView =  UICollectionView(
        frame: .zero,
        collectionViewLayout: makeLayout()
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func makeLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, env in
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(56))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.contentInsets = .init(top: 12, leading: 0, bottom: 0, trailing: 0)
            group.interItemSpacing = .fixed(12)

            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }

    private func setup() {
        collectionView.dataSource = dataSource
        collectionView.register(SkillCollectionViewCell.self, forCellWithReuseIdentifier: "SkillCollectionViewCell")

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

}
