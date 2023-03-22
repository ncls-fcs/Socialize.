//
//  UpdaterViewModel.swift
//  friend timer
//
//  Created by Nicolas Fuchs on 18.11.22.
//

import Foundation

//Updates every minute

class UpdaterViewModel: ObservableObject {
    @Published var index: Int = 0

    var timer: Timer?
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { _ in
            self.refresh()
        })
    }
    deinit {
        timer?.invalidate()
    }
    func refresh() {
        index += 1
    }
}
