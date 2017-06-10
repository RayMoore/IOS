//
//  CartTableViewCell.m
//  BasicUIDesign-project
//
//  Created by Ray on 08/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import "CartTableViewCell.h"
#import "CartSectionView.h"


@interface CartTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *chooseImage;
@property (weak, nonatomic) IBOutlet UIImageView *itemImage;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemAmountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *checkImage;
@property (weak, nonatomic) IBOutlet UILabel *itemTaxLabel;
@property (weak, nonatomic) IBOutlet UIView *checkView;


@property (assign,atomic) BOOL ifChoose;
@property (assign,atomic) BOOL ifShowTax;



@end

@implementation CartTableViewCell

-(void)setupWithItem:(Item*)item andAmount:(NSInteger) amount{
    
    self.itemImage.image = [UIImage imageNamed:item.picURL];
    self.descriptionLabel.text = item.itemDescription;
    self.itemPriceLabel.text = [@"￥" stringByAppendingFormat:@"%.2f",item.itemPrice];
    self.itemTaxLabel.text = [@"税费：￥" stringByAppendingFormat:@"%.2f",item.itemTax];
    self.itemAmountLabel.text = [@"×" stringByAppendingFormat:@"%ld",amount];
    
}

-(NSString*)getDescription{
    return self.descriptionLabel.text;
}

-(void)tapChoose{
    if(self.ifChoose == CHOOSE){
        self.ifChoose = NOT_CHOOSE;
        self.chooseImage.image = [UIImage imageNamed:NOT_CHOOSE_IMG];
    }else{
        self.ifChoose = CHOOSE;
        self.chooseImage.image = [UIImage imageNamed:CHOOSE_IMG];
    }
}

-(void)checkTaxDetail{
    if(self.ifShowTax == NOT_SHOW_TAX){
        //show tax view
        self.ifShowTax = SHOW_TAX;
        ShowTaxView *taxView = [[ShowTaxView alloc] init];
        CGRect taxFrame = CGRectMake(0, 0, CGFLOAT_MAX, 60);
        UIView *newView = [[UIView alloc] init];
        self.
    }else{
        //close tax view
        self.ifShowTax = NOT_SHOW_TAX;
    }
}


-(void)setWidth:(CGFloat)width{
//    self.frame.size.width = width;
    
}


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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.chooseImage.image = [UIImage imageNamed:CHOOSE_IMG];
    self.ifChoose = YES;
    self.ifShowTax = NOT_SHOW_TAX;
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

@end
