//
//  MKMapView+ZoomLevel.h
//  Tennis
//
//  Created by Yuri on 2016/11/2.
//  Copyright © 2016年 王迎军. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;
@end
