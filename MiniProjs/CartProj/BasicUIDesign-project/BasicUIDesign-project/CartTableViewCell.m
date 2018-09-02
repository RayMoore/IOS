//
//  CartTableViewCell.m
//  BasicUIDesign-project
//
//  Created by Ray on 08/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import "CartTableViewCell.h"
#import "CartSectionView.h"
#import "CartTableView.h"
#import "ImageChangeObserver.h"


@interface CartTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *chooseImage;
@property (weak, nonatomic) IBOutlet UIImageView *itemImage;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemAmountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *checkImage;
@property (weak, nonatomic) IBOutlet UILabel *itemTaxLabel;
@property (weak, nonatomic) IBOutlet UIView *checkView;
@property (weak, nonatomic) IBOutlet UIView *showTaxView;
@property (assign,atomic) CGFloat angle;
@property (strong,nonatomic) NSIndexPath *indexPath;
@property (strong,atomic) CartMainViewController *controller;
@property (strong,nonatomic) ImageChangeObserver *imageChangeObserver;
@property (assign,nonatomic) CGFloat cellTax;
@property (assign,nonatomic) CGFloat cellPrice;
@property (assign,nonatomic) NSInteger cellAmount;


@property (assign,atomic) BOOL ifChoose;
@property (assign,atomic) BOOL ifShowTax;



@end

@implementation CartTableViewCell

-(void)setupWithItem:(Item*)item andAmount:(NSInteger) amount andIndexPath:(NSIndexPath*)indexPath andController:(CartMainViewController*)controller{
    
    /* reset all attributes when a new Item* comes in, whether it is the same Item*
     * cell is recycled, thus this part of initialization should not be included in
     * awakeFromNib method, cause the cell is only created once and the attributes
     * already initialized are remain the same. When a new Item* comes in, unexpected
     *old attributes may crashes the new ones.
     */
    
    self.chooseImage.image = [UIImage imageNamed:CHOOSE_IMG];
    self.ifChoose = YES;
    self.cellTax = item.itemTax;
    self.cellPrice = item.itemPrice;
    self.cellAmount = amount;
    self.indexPath = indexPath;
    
    // display item detail with input Item*
    self.itemImage.image = [UIImage imageNamed:item.picURL];
    self.descriptionLabel.text = item.itemDescription;
    self.itemPriceLabel.text = [@"￥" stringByAppendingFormat:@"%.2f",item.itemPrice];
    self.itemTaxLabel.text = [@"税费：￥" stringByAppendingFormat:@"%.2f",item.itemTax];
    self.itemAmountLabel.text = [@"×" stringByAppendingFormat:@"%ld",amount];
    
    
    /* note that when the cell is reused from tableview stack, self.controller and
     * self.imageChangeObserver are already initialized once, thus in this part we
     * should consider this situation, we don't alloc new instance for them in this
     * case.
     */
    
    if(self.controller == nil){
        self.controller = controller;
    }
    if(self.imageChangeObserver == nil){
        self.imageChangeObserver = [[ImageChangeObserver alloc] initWithIndexPath:self.indexPath andController:self.controller];
    }
    
    @try {
        [self addObserver:self.imageChangeObserver forKeyPath:@"ifChoose" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    } @catch (NSException *exception) {}
}


-(NSString*)getDescription{
    return self.descriptionLabel.text;
}


-(CGFloat)getTotalTax{
    return self.cellAmount * self.cellTax;
}


-(CGFloat)getTotalPrice{
    return self.cellAmount * self.cellPrice;
}

-(BOOL)getShowTaxStatus{
    return self.ifShowTax;
}

-(BOOL)getChooseStatus{
    return self.ifChoose;
}


// when click choose-image, change the back image and bind the BOOL ifChoose attributes to a new value.
-(void)tapChoose{
    if(self.ifChoose == CHOOSE){
        self.ifChoose = NOT_CHOOSE;
        self.chooseImage.image = [UIImage imageNamed:NOT_CHOOSE_IMG];
    }else{
        self.ifChoose = CHOOSE;
        self.chooseImage.image = [UIImage imageNamed:CHOOSE_IMG];
    }
}

-(void)reverseImage{
    self.angle+=M_PI;
    if(self.angle == 2 * M_PI){
        self.angle = 0;
    }
    CGAffineTransform transform = CGAffineTransformMakeRotation(self.angle);
    self.checkImage.transform = transform;
}

-(void)checkTaxDetail{
    [self reverseImage];
    if(self.ifShowTax == NOT_SHOW_TAX){
        //show tax view
        self.ifShowTax = SHOW_TAX;
        [self.showTaxView setHidden:NO];
    }else{
        //close tax view
        self.ifShowTax = NOT_SHOW_TAX;
        [self.showTaxView setHidden:YES];
    }
    [self.controller updateCellByShowingTaxDetailWithCellIndexPath:self.indexPath andIfShowTaxDetail:self.ifShowTax];
}



// for all choose action from section header
- (void)makeAllChooseBySelection:(BOOL)selection{
    if(self.ifChoose != selection){
        //do change the image
        //otherwise ignore
        if(selection == CHOOSE){
            self.ifChoose = CHOOSE;
            self.chooseImage.image = [UIImage imageNamed:CHOOSE_IMG];
        }else{
            self.ifChoose = NOT_CHOOSE;
            self.chooseImage.image = [UIImage imageNamed:NOT_CHOOSE_IMG];
        }
    }
}


// this function works when tableview initialize cell in the first time
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.ifShowTax = NOT_SHOW_TAX;
    self.angle = 0;
    [self.showTaxView setHidden:YES];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapChoose)];
    tapGesture.numberOfTapsRequired = 1;
    [self.chooseImage addGestureRecognizer:tapGesture];
    UITapGestureRecognizer *checkGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkTaxDetail)];
    checkGesture.numberOfTapsRequired = 1;
    [self.checkView addGestureRecognizer:checkGesture];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc{
    @try{
        [self removeObserver:self.imageChangeObserver forKeyPath:@"ifChoose"];
    }@catch(NSException *e){}
}

- (void)ignoreImageObserver{
    @try{
        [self removeObserver:self.imageChangeObserver forKeyPath:@"ifChoose"];
    }@catch(NSException *e){}
}

@end
