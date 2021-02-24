//
//  RoomSingerPlayerViewController.h
//  MusicPlayerV3
//
//  Created by Nghia on 24/02/2021.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN
@class RoomSingerPlayerViewController;

@protocol sendCurrent <NSObject>

-(void) sendData:(CMTime) current;

@end


@interface RoomSingerPlayerViewController : UIViewController
@property AVPlayer *player1;
@property CMTime current;
@property NSString *link;
@property id<sendCurrent> delegate;
@end

NS_ASSUME_NONNULL_END
