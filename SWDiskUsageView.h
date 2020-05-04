@interface SWDiskUsageView : UIView {
	UIView *_backgroundView;
	UIView *_diskBarView;
	UILabel *_usageLabel;
	uint64_t _usedDiskSpace;
    uint64_t _totalDiskSpace;
}
-(void)setup;
-(void)setBarBackgroundColor;
@end