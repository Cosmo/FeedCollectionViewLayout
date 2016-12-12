//
//  DataSource.swift
//  FeedCollectionViewLayout
//
//  Created by Devran Uenal on 11.12.16.
//  Copyright © 2016 Devran Uenal. All rights reserved.
//

import UIKit

open class VideosDataSource: NSObject, UICollectionViewDataSource {
    var universes: [Universe] = [
        Universe(name: "Marvel Cinematic Universe", people: [
            Person(name: "Iron Man"),
            Person(name: "Thor"),
            Person(name: "Hulk"),
            Person(name: "Captain America"),
            Person(name: "Hawkeye"),
            Person(name: "Black Widow"),
            Person(name: "Loki"),
            Person(name: "Nick Fury"),
            Person(name: "Maria Hill"),
            Person(name: "Phil Coulson"),
            Person(name: "J.A.R.V.I.S."),
            Person(name: "Pepper Potts")
            ]),
        Universe(name: "Marvel Netflix Series", people: [
            Person(name: "Daredevil"),
            Person(name: "Jessica Jones"),
            Person(name: "Luke Cage"),
            Person(name: "Iron Fist"),
            Person(name: "The Punisher")
            ]),
        Universe(name: "DC Extended Universe", people: [
            Person(name: "Batman"),
            Person(name: "Superman"),
            Person(name: "Wonder Woman"),
            Person(name: "Lex Luthor"),
            Person(name: "The Flash"),
            Person(name: "Aquaman"),
            Person(name: "Shazam!")
            ])
    ]
    
    public override init () {
        super.init()
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.universes.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.universes[section].people.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath) as! TextCollectionViewCell
        let universe = self.universes[indexPath.section]
        cell.textLabel.text = universe.people[indexPath.row].name
        return cell
    }
}
