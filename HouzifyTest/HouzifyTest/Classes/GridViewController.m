//
//  ViewController.m
//  HouzifyTest
//
//  Created by Bharath Kamath on 15/08/15.
//  Copyright (c) 2015 Bharath -. All rights reserved.
//

#import "GridViewController.h"
#import "HouzifyImageModel.h"
#import "GalleryView.h"
#import "AppDelegate.h"

@interface GridViewController ()

@end

@implementation GridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Fetch data async from server - for now fetch locally
    [self fetchData];
    
    // setup the grid view
    [self setupUI];

}

-(void)setupUI {
    
    self.navigationController.title = @"Houzify";
    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    _collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    [self.view addSubview:_collectionView];
}


-(void)fetchData {
    
    if(arrGridItems == nil)
        arrGridItems = [[NSMutableArray alloc] init];
    
    // allocate the data model
    
    HouzifyImageModel *houze1 = [[HouzifyImageModel alloc] initWithTitle:@"Canned Foods are handy during famine" thumb:@"Canning_thumb.png" image:@"Canning.png"];
    [arrGridItems addObject:houze1];
    
    HouzifyImageModel *houze2 = [[HouzifyImageModel alloc] initWithTitle:@"Canned Foods are handy during famine" thumb:@"DoWithLess_thumb.png" image:@"DoWithLess.png"];
    [arrGridItems addObject:houze2];
    
    HouzifyImageModel *houze3 = [[HouzifyImageModel alloc] initWithTitle:@"Canned Foods are handy during famine" thumb:@"FairShare_thumb.png" image:@"FairShare.png"];
    [arrGridItems addObject:houze3];
    
    HouzifyImageModel *houze4 = [[HouzifyImageModel alloc] initWithTitle:@"Canned Foods are handy during famine" thumb:@"GapInLine_thumb.png" image:@"GapInLine.png"];
    [arrGridItems addObject:houze4];
    
    HouzifyImageModel *houze5 = [[HouzifyImageModel alloc] initWithTitle:@"Canned Foods are handy during famine" thumb:@"Gunpowder_thumb.png" image:@"Gunpowder.png"];
    [arrGridItems addObject:houze5];
    
    HouzifyImageModel *houze6 = [[HouzifyImageModel alloc] initWithTitle:@"Canned Foods are handy during famine" thumb:@"MakeItStretch_thumb.png" image:@"MakeItStretch.png"];
    [arrGridItems addObject:houze6];
    
    HouzifyImageModel *houze7 = [[HouzifyImageModel alloc] initWithTitle:@"Canned Foods are handy during famine" thumb:@"WeCanDoIt_thumb.png" image:@"WeCanDoIt.png"];
    [arrGridItems addObject:houze7];
    
    HouzifyImageModel *houze8 = [[HouzifyImageModel alloc] initWithTitle:@"Canned Foods are handy during famine" thumb:@"WorkToWin_thumb.png" image:@"WorkToWin.png"];
    [arrGridItems addObject:houze8];
    
    
    HouzifyImageModel *houze9 = [[HouzifyImageModel alloc] initWithTitle:@"Canned Foods are handy during famine" thumb:@"Canning_thumb.png" image:@"Canning.png"];
    [arrGridItems addObject:houze9];
    
    HouzifyImageModel *houze10 = [[HouzifyImageModel alloc] initWithTitle:@"Canned Foods are handy during famine" thumb:@"DoWithLess_thumb.png" image:@"DoWithLess.png"];
    [arrGridItems addObject:houze10];
    
    HouzifyImageModel *houze11 = [[HouzifyImageModel alloc] initWithTitle:@"Canned Foods are handy during famine" thumb:@"FairShare_thumb.png" image:@"FairShare.png"];
    [arrGridItems addObject:houze11];
    
    HouzifyImageModel *houze12 = [[HouzifyImageModel alloc] initWithTitle:@"Canned Foods are handy during famine" thumb:@"GapInLine_thumb.png" image:@"GapInLine.png"];
    [arrGridItems addObject:houze12];
    
    HouzifyImageModel *houze13 = [[HouzifyImageModel alloc] initWithTitle:@"Canned Foods are handy during famine" thumb:@"Gunpowder_thumb.png" image:@"Gunpowder.png"];
    [arrGridItems addObject:houze13];
    
    HouzifyImageModel *houze14 = [[HouzifyImageModel alloc] initWithTitle:@"Canned Foods are handy during famine" thumb:@"MakeItStretch_thumb.png" image:@"MakeItStretch.png"];
    [arrGridItems addObject:houze14];
    
    HouzifyImageModel *houze15 = [[HouzifyImageModel alloc] initWithTitle:@"Canned Foods are handy during famine" thumb:@"WeCanDoIt_thumb.png" image:@"WeCanDoIt.png"];
    [arrGridItems addObject:houze15];
    
    HouzifyImageModel *houze16 = [[HouzifyImageModel alloc] initWithTitle:@"Canned Foods are handy during famine" thumb:@"WorkToWin_thumb.png" image:@"WorkToWin.png"];
    [arrGridItems addObject:houze16];
    

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrGridItems count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    UIImageView *ivwThumbnail = (UIImageView*)[cell viewWithTag:5];
    if (ivwThumbnail == nil) {
        ivwThumbnail = [[UIImageView alloc] initWithFrame:cell.bounds];
        ivwThumbnail.contentMode = UIViewContentModeScaleAspectFill;
        ivwThumbnail.tag = 5;
        ivwThumbnail.userInteractionEnabled = FALSE;
        [cell addSubview:ivwThumbnail];
    }
    
    cell.clipsToBounds = TRUE;
    HouzifyImageModel *imageModel = [arrGridItems objectAtIndex:indexPath.row];
    ivwThumbnail.image = [UIImage imageNamed:imageModel.thumbnail];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width = CGRectGetWidth(self.view.frame);
    // subtract padding
    width -= (4*8);
    return CGSizeMake(width/3, 130);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 5, 5, 5); //top,left,bottom,right
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * theAttributes = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
    
    CGRect cellFrameInSuperview = [collectionView convertRect:theAttributes.frame toView:[collectionView superview]];
    

    GalleryView *vew = [[GalleryView alloc] initWithFrame:cellFrameInSuperview current:indexPath.row allItems:arrGridItems];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.window addSubview:vew];
    [appDelegate.window insertSubview:vew atIndex:([[appDelegate.window subviews]count])];
    
//    [self.view addSubview:vew];
    [vew show];
    
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
