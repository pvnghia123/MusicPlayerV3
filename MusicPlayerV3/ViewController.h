//
//  ViewController.h
//  MusicPlayerV3
//
//  Created by Nghia on 23/02/2021.
//

#import <UIKit/UIKit.h>
#import "Video.h"
#import "PLayerVideoViewController.h"

@class ViewController;

@protocol viewControllerDelegate<NSObject>
//method delegte
    -(void) addVideoVCtoPlayVideo: (ViewController *) viewController Video:(Video *) video;
@end

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource ,viewControllerDelegate>


@end

