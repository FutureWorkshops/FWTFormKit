//
//  LFSNameAndValueAndSwitchCell.m
//  LFSLifeScale
//
//  Created by Yevgeniy Prokoshev on 06/02/2015.
//
//

#import "FWTNameAndSwitchCell.h"


@interface FWTNameAndSwitchCell ()

@property (nonatomic) NSNumber *switchSelectorState; // KVO For UISSwtich .on property is not working.

@end
@implementation FWTNameAndSwitchCell

- (void)awakeFromNib {

    [self.switchSelector addTarget:self action:@selector(_KVOWorkAround:) forControlEvents:UIControlEventValueChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) _KVOWorkAround:(UISwitch *) sender
{
    self.switchSelectorState = [NSNumber numberWithBool:sender.on];
}


-(void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

@end
