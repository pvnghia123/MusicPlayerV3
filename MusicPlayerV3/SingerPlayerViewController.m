//
//  SingerPlayerViewController.m
//  MusicPlayerV3
//
//  Created by Nghia on 24/02/2021.
//

#import "SingerPlayerViewController.h"

@interface SingerPlayerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *txtCurentime;
@property (weak, nonatomic) IBOutlet UILabel *txtTotalTime;
@property (weak, nonatomic) IBOutlet UITextField *txtPlayer;
@property AVPlayer *player;
@property bool isPlay;
@property (weak, nonatomic) IBOutlet UIButton *uibtnPlay;
@property (weak, nonatomic) IBOutlet UIButton *uiBtnMute;
@property NSTimer *timer;
@property (weak, nonatomic) IBOutlet UISlider *uiSeekbar;
@property NSString *link;

@end

@implementation SingerPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self Playvideo:@"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"];
    self.link=@"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
    
}
- (IBAction)btnPlayUrl:(id)sender {
    if(![self.txtPlayer.text isEqualToString:@""]){
        [self.timer invalidate];
        [self Playvideo:self.txtPlayer.text];
        self.link = self.txtPlayer.text;
    }
}
- (IBAction)btnPlay:(id)sender {
    if(self.isPlay){
        [self.player pause];
        
        [self.uibtnPlay setImage: [UIImage systemImageNamed:@"pause.fill"] forState:UIControlStateNormal];
        self.isPlay=false;
        // huy bo dem thời gian
        [self.timer invalidate];
    }else{
        self.isPlay=true;
        [self.player play];
        [self.uibtnPlay setImage: [UIImage systemImageNamed:@"play.fill"] forState:UIControlStateNormal];
        
        // tthem 1 bộ đếm thời gian
        self.timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:true];
    }
}
- (IBAction)btnPre10s:(id)sender {
    
    CMTime current = self.player.currentTime;
    CMTime temp=CMTimeMake(10, 1);
    
    CMTime newTime = CMTimeSubtract(current, temp);
    
    if(CMTimeCompare(newTime, kCMTimeZero)==-1){
        [self.player seekToTime:kCMTimeZero];
    }else{
        [self.player seekToTime:newTime];
    }
}
- (IBAction)btnNext10s:(id)sender {
    CMTime current = self.player.currentTime;
    CMTime temp=CMTimeMake(10, 1);
    
    CMTime newTime = CMTimeAdd(current, temp);
    
    if(CMTimeCompare(newTime, self.player.currentItem.asset.duration)==1){ //lon hon
        
        [self.player seekToTime:self.player.currentItem.asset.duration];
        [self.player pause];
        
    }else{
        [self.player seekToTime:newTime];
    }
    
}
- (IBAction)btnMute:(id)sender {
    if([self.player isMuted]){
        
        [self.uiBtnMute setImage: [UIImage systemImageNamed:@"speaker.slash.fill"] forState:UIControlStateNormal];
        [self.player setMuted:false];
        
    }else{
        [self.uiBtnMute setImage: [UIImage systemImageNamed:@"speaker.fill"] forState:UIControlStateNormal];
        [self.player setMuted:true];
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    RoomSingerPlayerViewController *sendViewController = (RoomSingerPlayerViewController *) segue.destinationViewController;
    
    sendViewController.current = self.player.currentTime;
    sendViewController.link = self.link;
    sendViewController.player1 = self.player;
    sendViewController.delegate = self;

    [self.player pause];
    
    [self.timer invalidate];
    
}

- (IBAction)seekbarValueChanged:(UISlider *)sender {
    // huy bộ dêmds thươit gian
    [self.timer invalidate];
    
    // uopdate lại curentTimer
    [self.player seekToTime:CMTimeMake( self.uiSeekbar.value,1)];
    // bộ dếm thời gian mới
    self.timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:true];
    
}
-(NSString *) convertCMTimetoString: (CMTime) time{
    
    float total = CMTimeGetSeconds(time);
    
    int houre =(int) total / 3600 ;
    
    int minute =(int) total % 3600 / 60;
    
    int seconds =(int) total % 3600 % 60;
    
    if(houre == 0){
        return  [NSString stringWithFormat:@"%02d :%02d ",minute ,seconds];
    }else{
        return  [NSString stringWithFormat:@"%02d :%02d :%02d",houre,minute ,seconds];
    }
    
}
-(void) updateTime{
    
    //CMTime *t = self.player.currentTime;
    
    NSString *curent = [self convertCMTimetoString:self.player.currentTime];
    self.txtCurentime.text = curent;
    self.uiSeekbar.value = CMTimeGetSeconds(self.player.currentTime);
    
}
-(void) Playvideo: (NSString *) link{
    NSURL *url= [NSURL URLWithString:link];
    
    AVAsset *aset = [AVAsset assetWithURL:url];
    AVPlayerItem *item= [AVPlayerItem playerItemWithAsset:aset];
    
    if(self.player!=nil){
        [self.player replaceCurrentItemWithPlayerItem:item];
    }else{
        self.player= [AVPlayer playerWithPlayerItem:item];
    }
  
    
    AVPlayerLayer *layer= [AVPlayerLayer playerLayerWithPlayer:self.player];
    layer.frame= self.uiView.bounds;
    
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    
    [self.uiView.layer addSublayer:layer];
    
    self.txtTotalTime.text= [self convertCMTimetoString:self.player.currentItem.asset.duration];
    
    
    self.isPlay = true;
    
    [self.player play];
    
    
    self.timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:true];
    
    self.uiSeekbar .maximumValue = CMTimeGetSeconds(self.player.currentItem.asset.duration);
    self.uiSeekbar .minimumValue = 0;
}
- (void)sendData:(CMTime)current{
    [self.player pause];

    
    [self.player seekToTime:current];
    self.timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:true];

    [self.player play];
}




@end
