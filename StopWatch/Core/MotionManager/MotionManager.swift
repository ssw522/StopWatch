//
//  MotionManager.swift
//  StopWatch
//
//  Created by iOS신상우 on 2/1/25.
//

import Foundation
import CoreMotion
import Combine

final class MotionManager: ObservableObject {
    private var motionManager = CMMotionManager()
    
    @Published var acceleration: (x: Double, y: Double, z: Double) = (0, 0, 0) // 가속도 데이터
    @Published var rotationRate: (x: Double, y: Double, z: Double) = (0, 0, 0) // 자이로스코프 데이터
    @Published var attitude: (roll: Double, pitch: Double, yaw: Double) = (0, 0, 0) // 기울기 데이터
    
    func startMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (motion, error) in
                guard let self = self, let motion = motion else { return }

                // 가속도 데이터
                self.acceleration = (motion.userAcceleration.x, motion.userAcceleration.y, motion.userAcceleration.z)
                
                // 자이로스코프 데이터
                self.rotationRate = (motion.rotationRate.x, motion.rotationRate.y, motion.rotationRate.z)
                
                // 기울기 데이터
                self.attitude = (motion.attitude.roll, motion.attitude.pitch, motion.attitude.yaw)
            }
        }
    }
    
    func stopMotionUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }
}
