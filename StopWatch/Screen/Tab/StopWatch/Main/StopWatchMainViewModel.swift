//
//  StopWatchMainViewModel.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/18/25.
//

import Foundation
import UIKit.UIDevice
import Combine

final class StopWatchMainViewModel: ViewModelable {
    
    let coordinator: StopWatchCoordinator
    
    private let dependency: DependencyBox
    private var cancellable = Set<AnyCancellable>()
    private let motionManager: MotionManager
    private var focustTimeViewModel: FocusTimeViewModel?
    
    @Published var state: State = .init()
    
    init(
        coordinator: StopWatchCoordinator,
        state: State = .init(),
        dependency: DependencyBox = .live,
        motionManager: MotionManager = .init()
    ) {
        self.coordinator = coordinator
        self.state = state
        self.dependency = dependency
        self.motionManager = motionManager
    }
    
    struct State {
        var startDate: Date = .now
        var endDate: Date = .now
        var breakTiem: CGFloat = .zero
        var recentTimeCheckList: [TimeCheck] = []
        var todayFocusTime: Double = .zero
    }
    
    enum Action {
        case onAppear
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .onAppear:
            motionManager.startMotionUpdates()
            observeAttitude()
            
            let allTimeCheckList = try? timecheckRepo.getAll().filter {
                $0.startDate.formattedString(by: .yyyyMMdd) == Date.now.formattedString(by: .yyyyMMdd)
            }
            
            state.todayFocusTime = allTimeCheckList?.reduce(0.0, { $0 + $1.focusTime }) ?? .zero
            allTimeCheckList.flatMap {
                state.recentTimeCheckList = $0.sorted(by: { $0.startDate > $1.startDate }).prefix(3).map { $0 }
            }
        }
    }
    
    func observeAttitude() {
        UIDevice.current.isProximityMonitoringEnabled = false
        
        let proximityPublisher = NotificationCenter.default
                    .publisher(for: UIDevice.proximityStateDidChangeNotification)

        let attitudePublisher = motionManager.$attitude
        
        proximityPublisher.sink { _ in
            let isOnProximity = UIDevice.current.proximityState
            
            if isOnProximity {

            } else {
                self.motionManager.startMotionUpdates()
            }
        }
        .store(in: &cancellable)
        
        attitudePublisher
            .sink { motion in
                let degree = abs(motion.roll * 180.0 / Double.pi)
                
                if degree >= 100 { // 100도 이상 기울어지면 근접 센서 가동
                    UIDevice.current.isProximityMonitoringEnabled = true
                    
                    if degree >= 160 && UIDevice.current.proximityState == true { // 160도 이상 기울어지고 근접 센서가 true이면 타이머 시작
                        
                        if let focustTimeViewModel = self.focustTimeViewModel {
                            if focustTimeViewModel.state.isFocusing == false {
                                let startTime = focustTimeViewModel.state.endDate?.timeIntervalSince1970 ?? 0
                                let endTime = Date.now.timeIntervalSince1970
                                focustTimeViewModel.state.breakTime += (endTime - startTime)
                                focustTimeViewModel.state.endDate = .none
                                focustTimeViewModel.state.isFocusing = true
                            }
                        } else {
                            self.focustTimeViewModel = FocusTimeViewModel(
                                coordinator: self.coordinator,
                                focusMode: .motion,
                                state: .init(startDate: .now, isFocusing: true),
                                delegate: self
                            )

                            let view = FocusTimeView(viewModel: self.focustTimeViewModel!).viewController
                            
                            self.coordinator.present(view)
                        }
                        
                        self.motionManager.stopMotionUpdates()  // 코어모션 업데이트 메소드 중단! ( 근접센서 false시 재 작동 )
                    }
                } else if degree < 100 && UIDevice.current.proximityState == false { // 100도 이하고 근접 센서가 false면 근접센서 작동 중단 + 타이머 가동중이면 타이머도 중단
                    UIDevice.current.isProximityMonitoringEnabled = false
                    
                    if self.focustTimeViewModel?.state.isFocusing == true {
                        self.focustTimeViewModel?.state.isFocusing = false
                        self.focustTimeViewModel?.state.endDate = .now
                    }
                }
            }.store(in: &cancellable)
    }
}

extension StopWatchMainViewModel: FocusTimeViewModelDelegate {
    func saveTimeCheck(with timeCheck: TimeCheck) {
        do {
            try timecheckRepo.create(entity: timeCheck)
            state.recentTimeCheckList.insert(timeCheck, at: 0)
            
            if state.recentTimeCheckList.count > 3 {
                state.recentTimeCheckList.removeLast()
            }
            
            coordinator.dismiss()
            focustTimeViewModel = .none
            
        } catch {
            coordinator.showToast("시간 저장 실패")
        }
    }
}

private extension StopWatchMainViewModel {
    var timecheckRepo: any TimeCheckReopsitory {
        dependency.resolve()
    }
}
