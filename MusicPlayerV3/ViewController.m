//
//  ViewController.m
//  MusicPlayerV3
//
//  Created by Nghia on 23/02/2021.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *uiTbvVideo;

@property Video *v;

@property NSArray *array;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.uiTbvVideo.delegate=self;
    self.uiTbvVideo.dataSource=self;
    [self.uiTbvVideo reloadData];
    
    Video *v1=[[Video alloc] init];
    v1.image=@"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg";
    v1.link=@"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
    v1.title=@"Big Buck Bunny";
    
    Video *v2=[[Video alloc] init];
    v2.image=@"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg";
    v2.link=@"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4";
    v2.title=@"Elephant Dream";
    
    Video *v3=[[Video alloc] init];
    v3.image=@"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg";
    v3.link=@"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4";
    v3.title=@"For Bigger Blazes";
    
    self.array=[ NSArray arrayWithObjects:v1,v2,v3, nil];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
   
    
    Video *v = self.array[indexPath.row];
    
    NSURL *url= [NSURL URLWithString:v.image];
    
    NSData *data= [NSData dataWithContentsOfURL:url];
    
    cell.imageView.image= [UIImage imageWithData:data];

    cell.textLabel.text=v.title;
    
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"select %@", self.array[indexPath.item]);
    self.v= self.array[indexPath.row];
    
    
    PLayerVideoViewController *controller = [[PLayerVideoViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    controller.link = self.v;
    [self.navigationController pushViewController:controller animated:YES];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    PLayerVideoViewController *controller= (PLayerVideoViewController *) segue.destinationViewController;
    controller.link=_v;

}





@end
