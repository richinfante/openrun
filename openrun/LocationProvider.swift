//
//  LocationProvider.swift
//  openrun
//
//  Created by Rich Infante on 5/23/18.
//  Copyright © 2018 Richard Infante. All rights reserved.
//

import Foundation
import CoreLocation

class LocationProvider : NSObject, CLLocationManagerDelegate {
    
    static var shared = LocationProvider()
    
    let location = CLLocationManager()
    var activity : Activity?
    override init() {
        super.init()
        
        location.delegate = self
        location.activityType = .fitness
        location.allowDeferredLocationUpdates(untilTraveled: 15, timeout: 5)
        location.allowsBackgroundLocationUpdates = true
        location.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func startUpdatingLocation() {
        location.requestAlwaysAuthorization()
        location.startUpdatingLocation()
    }
    
    func beginRecordingActivity() {
        if activity == nil {
            self.activity = Activity()
        }
        
        activity?.start()
    }
    
    func stopRecordingActivity() {
        activity?.stop()
        location.stopUpdatingLocation()
    }
    
    
    /*
     *  locationManager:didUpdateLocations:
     *
     *  Discussion:
     *    Invoked when new locations are available.  Required for delivery of
     *    deferred locations.  If implemented, updates will
     *    not be delivered to locationManager:didUpdateToLocation:fromLocation:
     *
     *    locations is an array of CLLocation objects in chronological order.
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("[locationmanager] got \(locations.count) locations")
        guard let activity = activity else { return }
//
        if locations.count > 0 {
            print("coord: \(locations[0].coordinate)")
            print("alt: \(locations[0].altitude)")
            print("speed: \(locations[0].speed)")
            print("accuracy: \(locations[0].horizontalAccuracy)")
            print("v-accuracy: \(locations[0].verticalAccuracy)")
        }
        
        for item in locations {
            activity.add(point: item)
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print(error)
    }

    
//
//    /*
//     *  locationManager:didUpdateHeading:
//     *
//     *  Discussion:
//     *    Invoked when a new heading is available.
//     */
//    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
//
//    }
//
//
//    /*
//     *  locationManagerShouldDisplayHeadingCalibration:
//     *
//     *  Discussion:
//     *    Invoked when a new heading is available. Return YES to display heading calibration info. The display
//     *    will remain until heading is calibrated, unless dismissed early via dismissHeadingCalibrationDisplay.
//     */
////    func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
////        return false
////    }
////
//
//    /*
//     *  locationManager:didDetermineState:forRegion:
//     *
//     *  Discussion:
//     *    Invoked when there's a state transition for a monitored region or in response to a request for state via a
//     *    a call to requestStateForRegion:.
//     */
//    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
//
//    }
//
//
//    /*
//     *  locationManager:didRangeBeacons:inRegion:
//     *
//     *  Discussion:
//     *    Invoked when a new set of beacons are available in the specified region.
//     *    beacons is an array of CLBeacon objects.
//     *    If beacons is empty, it may be assumed no beacons that match the specified region are nearby.
//     *    Similarly if a specific beacon no longer appears in beacons, it may be assumed the beacon is no longer received
//     *    by the device.
//     */
//    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
//
//    }
//
//
//    /*
//     *  locationManager:rangingBeaconsDidFailForRegion:withError:
//     *
//     *  Discussion:
//     *    Invoked when an error has occurred ranging beacons in a region. Error types are defined in "CLError.h".
//     */
//    func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
//
//    }
//
//
//    /*
//     *  locationManager:didEnterRegion:
//     *
//     *  Discussion:
//     *    Invoked when the user enters a monitored region.  This callback will be invoked for every allocated
//     *    CLLocationManager instance with a non-nil delegate that implements this method.
//     */
//    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
//
//    }
//
//
//    /*
//     *  locationManager:didExitRegion:
//     *
//     *  Discussion:
//     *    Invoked when the user exits a monitored region.  This callback will be invoked for every allocated
//     *    CLLocationManager instance with a non-nil delegate that implements this method.
//     */
//    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
//
//    }
//
//
//    /*
//     *  locationManager:didFailWithError:
//     *
//     *  Discussion:
//     *    Invoked when an error has occurred. Error types are defined in "CLError.h".
//     */
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//
//    }
//
//
//    /*
//     *  locationManager:monitoringDidFailForRegion:withError:
//     *
//     *  Discussion:
//     *    Invoked when a region monitoring error has occurred. Error types are defined in "CLError.h".
//     */
//    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
//
//    }
//
//
    /*
     *  locationManager:didChangeAuthorizationStatus:
     *
     *  Discussion:
     *    Invoked when the authorization status changes for this application.
     */
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(String(describing: status))
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            location.startUpdatingLocation()
            print("Starting...")
        }
    }
//
//
//    /*
//     *  locationManager:didStartMonitoringForRegion:
//     *
//     *  Discussion:
//     *    Invoked when a monitoring for a region started successfully.
//     */
//    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
//
//    }
//
//
//    /*
//     *  Discussion:
//     *    Invoked when location updates are automatically paused.
//     */
//    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
//
//    }
//
//
//    /*
//     *  Discussion:
//     *    Invoked when location updates are automatically resumed.
//     *
//     *    In the event that your application is terminated while suspended, you will
//     *      not receive this notification.
//     */
//    func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
//
//    }
//
//
//    /*
//     *  locationManager:didFinishDeferredUpdatesWithError:
//     *
//     *  Discussion:
//     *    Invoked when deferred updates will no longer be delivered. Stopping
//     *    location, disallowing deferred updates, and meeting a specified criterion
//     *    are all possible reasons for finishing deferred updates.
//     *
//     *    An error will be returned if deferred updates end before the specified
//     *    criteria are met (see CLError), otherwise error will be nil.
//     */
//    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
//
//    }
//
//
//    /*
//     *  locationManager:didVisit:
//     *
//     *  Discussion:
//     *    Invoked when the CLLocationManager determines that the device has visited
//     *    a location, if visit monitoring is currently started (possibly from a
//     *    prior launch).
//     */
//    @available(iOS 8.0, *)
//    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
//
//    }
}

