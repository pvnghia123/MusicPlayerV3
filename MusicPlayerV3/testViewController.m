//
//  testViewController.m
//  MusicPlayerV3
//
//  Created by Nghia on 24/02/2021.
//

#import "testViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface testViewController ()
@property (weak, nonatomic) IBOutlet UIView *uiView;
@property AVPlayer *player;

@end

@implementation testViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    

}

- (void)viewWillAppear:(BOOL)animated{
    NSURL *url= [NSURL URLWithString:@"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"];
    
    AVAsset *aset = [AVAsset assetWithURL:url];
    AVPlayerItem *item= [AVPlayerItem playerItemWithAsset:aset];
    self.player= [AVPlayer playerWithPlayerItem:item];
    AVPlayerLayer *layer= [AVPlayerLayer playerLayerWithPlayer:self.player];
    layer.frame= self.uiView.bounds;
    
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    
    [self.uiView.layer addSublayer:layer];
    [self.player play];
}


@end
