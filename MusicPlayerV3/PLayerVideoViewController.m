//
//  PLayerVideoViewController.m
//  MusicPlayerV3
//
//  Created by Nghia on 23/02/2021.
//

#import "PLayerVideoViewController.h"

@interface PLayerVideoViewController ()
@property (weak, nonatomic) IBOutlet UIView *uiView;
@property Video *videoPlay;

@end

@implementation PLayerVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int a=0;
    // Do any additional setup after loading the view.
}
- (void)addVideoVCtoPlayVideo:(ViewController *)viewController Video:(Video *)video{
    self.videoPlay = video;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
