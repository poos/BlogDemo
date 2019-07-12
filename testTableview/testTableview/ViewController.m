//
//  ViewController.m
//  testTableview
//
//  Created by biesx on 2019/7/4.
//  Copyright © 2019 biesx. All rights reserved.
//

#include <libkern/OSAtomic.h>
#include <execinfo.h>


#import "ViewController.h"

#define RGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSMutableArray *data;
@property(nonatomic, strong) NSMutableArray *section1;
@property(nonatomic, strong) NSMutableArray *section2;
@property(nonatomic, strong) NSMutableArray *section3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self setupViews];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupViews {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    [self.view addSubview:tableView];
    
    tableView.sectionHeaderHeight = 20;
    tableView.rowHeight = 44;
    tableView.dataSource = self;
    tableView.delegate = self;
    
    _section1 = [NSMutableArray arrayWithObjects:@1, @2, nil];
    _section2 = [NSMutableArray arrayWithObjects:@1, @2, nil];
    _section3 = [NSMutableArray arrayWithObjects:@1, nil];
    _data = [NSMutableArray arrayWithObjects:_section1, _section2, _section3, nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    int count = 0;
    
    if (_section1.count) {
        count ++;
    }
    
    if (_section2.count) {
        count ++;
    }
    
    if (_section3.count) {
        count ++;
    }
    
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *a = _data[section];
    return a.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.backgroundColor = RGB(arc4random()%255,arc4random()%255,arc4random()%255);
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
    label.text = @"header";
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor blackColor];
    [view addSubview:label];
    
    return view;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray *a = _data[indexPath.section];
        [a removeObjectAtIndex:indexPath.row];
        
        // 如果这样调用会发生崩溃
        //                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
        //        if (a.count == 0) { // 要根据情况直接删除section或者仅仅删除row
        //            [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        //
        //        } else {
        //            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //        }
        
        
        void* callstack[128];
        int frames = backtrace(callstack, 128);
        char **strs = backtrace_symbols(callstack, frames);
        int i;
        NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
        for (i = 0;i < 4;i++){
            [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
        }
        free(strs);
        NSLog(@"=====>>>>>堆栈<<<<<=====\n%@",backtrace);
        //
        //
        
    }
}


@end

//#import <mach/thread.h>
//#include <time.h>
//
//NSString *_bs_backtraceOfThread(thread_t thread) {
//    uintptr_t backtraceBuffer[50];
//    int i = 0;
//    NSMutableString *resultString = [[NSMutableString alloc] initWithFormat:@"Backtrace of Thread %u:\n", thread];
//
//    _STRUCT_MCONTEXT machineContext;
//    if(!bs_fillThreadStateIntoMachineContext(thread, &machineContext)) {
//        return [NSString stringWithFormat:@"Fail to get information about thread: %u", thread];
//    }
//
//    const uintptr_t instructionAddress = bs_mach_instructionAddress(&machineContext);
//    backtraceBuffer[i] = instructionAddress;
//    ++i;
//
//    uintptr_t linkRegister = bs_mach_linkRegister(&machineContext);
//    if (linkRegister) {
//        backtraceBuffer[i] = linkRegister;
//        i++;
//    }
//
//    if(instructionAddress == 0) {
//        return @"Fail to get instruction address";
//    }
//
//    BSStackFrameEntry frame = {0};
//    const uintptr_t framePtr = bs_mach_framePointer(&machineContext);
//    if(framePtr == 0 ||
//       bs_mach_copyMem((void *)framePtr, &frame, sizeof(frame)) != KERN_SUCCESS) {
//        return @"Fail to get frame pointer";
//    }
//
//    for(; i < 50; i++) {
//        backtraceBuffer[i] = frame.return_address;
//        if(backtraceBuffer[i] == 0 ||
//           frame.previous == 0 ||
//           bs_mach_copyMem(frame.previous, &frame, sizeof(frame)) != KERN_SUCCESS) {
//            break;
//        }
//    }
//
//    int backtraceLength = i;
//    Dl_info symbolicated[backtraceLength];
//    bs_symbolicate(backtraceBuffer, symbolicated, backtraceLength, 0);
//    for (int i = 0; i < backtraceLength; ++i) {
//        [resultString appendFormat:@"%@", bs_logBacktraceEntry(i, backtraceBuffer[i], &symbolicated[i])];
//    }
//    [resultString appendFormat:@"\n"];
//    return [resultString copy];
//}
