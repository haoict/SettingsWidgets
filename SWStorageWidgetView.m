#import "SWStorageWidgetView.h"

@implementation SWStorageWidgetView

-(void)setup {
    NSBundle *bundle = [[NSBundle alloc] initWithPath:@"/Library/Application Support/SettingsInfo"];
	NSString *imagePath = [bundle pathForResource:@"settingsicon" ofType:@"png"];
	UIImage *storageIconImage = [UIImage imageWithContentsOfFile:imagePath];
	UIImage *storageIconImageScaled =  [UIImage imageWithCGImage:[storageIconImage CGImage] scale:(storageIconImage.scale * 3) orientation:(storageIconImage.imageOrientation)];

    _settingsIconImageView = [[UIImageView alloc] initWithImage:storageIconImageScaled];
	_settingsIconImageView.layer.masksToBounds = YES;
	_settingsIconImageView.layer.cornerRadius = 14.5;
    _settingsIconImageView.translatesAutoresizingMaskIntoConstraints = NO;

    _storageHeaderLabel = [[UILabel alloc] init];
	_storageHeaderLabel.text = @"Storage";
	_storageHeaderLabel.font = [UIFont boldSystemFontOfSize:15];
    _storageHeaderLabel.textAlignment = NSTextAlignmentLeft;
    _storageHeaderLabel.translatesAutoresizingMaskIntoConstraints = NO;
	//[_storageHeaderLabel sizeToFit];

    _diskUsageView = [[SWDiskUsageView alloc] init];
    _diskUsageView.translatesAutoresizingMaskIntoConstraints = NO;

    [self addSubview: _storageHeaderLabel];
    [self addSubview: _diskUsageView];   
    [self addSubview: _settingsIconImageView];

	[_storageHeaderLabel.leadingAnchor constraintEqualToAnchor: _settingsIconImageView.trailingAnchor constant:7.5].active = YES;
	[_storageHeaderLabel.centerYAnchor constraintEqualToAnchor: _settingsIconImageView.centerYAnchor].active = YES;

	[_settingsIconImageView.topAnchor constraintEqualToAnchor: self.topAnchor constant: 10].active = YES;
	[_settingsIconImageView.leadingAnchor constraintEqualToAnchor: self.leadingAnchor constant:10].active = YES;

    [_diskUsageView.bottomAnchor constraintEqualToAnchor: self.bottomAnchor constant:-10].active = YES;
    [_diskUsageView.leadingAnchor constraintEqualToAnchor: self.leadingAnchor].active = YES;
    [_diskUsageView.trailingAnchor constraintEqualToAnchor: self.trailingAnchor].active = YES;
    [_diskUsageView setup];
}
@end