//
//  ViewController.swift
//  VideoApp
//
//  Created by Hridayedeep Gupta on 20/09/23.
//

import UIKit

class ViewController: UIViewController {

    private var tableView: UITableView!
    private var viewModel: [ViewModel.Video] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: String(describing: TableViewCell.self))
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        fetchData()
    }

    private func fetchData() {
        guard let path = Bundle.main.path(forResource: "media", ofType: "json") else { return }
        do {
            let data = try NSData(contentsOfFile: path, options: .mappedIfSafe) as Data
            let result = try JSONDecoder().decode(VideoResult.self, from: data)
            convert(result.videos)
            tableView.reloadData()
        } catch {
            print("Error caught -> ", error)
        }
    }

    private func convert(_ videos: [Video]) {
        viewModel = videos.map { video in
            return ViewModel.Video(title: video.title, description: video.description, videoUrl: video.sources, isDownloaded: (VideoProvider.getLocalURL(for: video.sources) != nil))
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableViewCell.self)) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(VideoPlayerVC(viewModel: viewModel[indexPath.row]), animated: true)
    }
}



