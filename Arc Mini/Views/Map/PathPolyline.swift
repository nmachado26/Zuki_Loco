// Created by Matt Greenfield on 16/11/15.
// Copyright (c) 2015 Big Paua. All rights reserved.

import MapKit

class PathPolyline: MKPolyline, ArcAnnotation {

    var timelineItem: ArcTimelineItem?
    var color: UIColor?

    convenience init(timelineItem: ArcTimelineItem? = nil, coordinates: UnsafePointer<CLLocationCoordinate2D>, count: Int, color: UIColor, disabled: Bool = false) {
        self.init(coordinates: coordinates, count: count)
        self.timelineItem = timelineItem
        self.color = disabled ? UIColor.lightGray.withAlphaComponent(0.5) : color
    }

    var renderer: MKPolylineRenderer {
        let renderer = MKPolylineRenderer(polyline: self)
        renderer.strokeColor = color
        renderer.lineWidth = 5
        return renderer
    }

}
