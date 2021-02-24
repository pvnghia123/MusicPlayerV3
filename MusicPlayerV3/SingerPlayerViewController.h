//
//  SingerPlayerViewController.h
//  MusicPlayerV3
//
//  Created by Nghia on 24/02/2021.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "RoomSingerPlayerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SingerPlayerViewController : UIViewController<sendCurrent>
@property (weak, nonatomic) IBOutlet UIView *uiView;

@end

NS_ASSUME_NONNULL_END
