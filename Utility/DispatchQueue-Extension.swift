//
//  DispatchQueue-Extension.swift
//  gitsearch (iOS)
//
//  Created by 楊勇 on R 4/02/18.
//

import Foundation
extension DispatchQueue {
    func debounce(delay: DispatchTimeInterval) -> (_ action: @escaping () -> ()) -> () {
        var lastFireTime: DispatchTime = .now()

        return { [weak self, delay] action in
            let deadline: DispatchTime = .now() + delay
            lastFireTime = .now()
            self?.asyncAfter(deadline: deadline) { [delay] in
                let now: DispatchTime = .now()
                let when: DispatchTime = lastFireTime + delay
                if now < when { return }
                lastFireTime = .now()
                action()
            }
        }
    }
    func throttle(delay: DispatchTimeInterval) -> (_ action: @escaping () -> ()) -> () {
            var lastFireTime: DispatchTime = .now()

            return { [weak self, delay] action in
                let deadline: DispatchTime = .now() + delay
                self?.asyncAfter(deadline: deadline) { [delay] in
                    let now: DispatchTime = .now()
                    let when: DispatchTime = lastFireTime + delay
                    if now < when { return }
                    lastFireTime = .now()
                    action()
                }
            }
    }
}
