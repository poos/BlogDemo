# AspectOrientedProgramming


使用swift实现的动态打点


使用了一个cvs表来定义打点地方，甚至通过服务端配置可以**随时调整打点**：
```
ViewController,click,buttonAction,trackName,trackkeys
ViewController,click,buttonActionNext:,trackName,trackkeys
TableViewController,tableSelect,tableView:didSelectRowAtIndexPath:,,
ViewController,lifeCycle,viewDidLoad,,
TableViewController,lifeCycle,viewDidLoad,,
ViewController,lifeCycle,viewWillLayoutSubviews,,
ViewController,other,buttonActionNext2:,,
,,,,
```

1. Demo中对常用的buttonClick，tableSelect，lifeCycle做了监听，在相应的地方会触发打印

2. Demo中使用cvs来配置打点的类，方法名，参数等


完全是不侵入业务的，甚至移除了TrackManager这个文件夹原项目仍然可以很好运行


**使用的结果呢**： 它在Demo中可以完美的检测和打点.....

### [参考博客：Swift打点讨论](https://poos.github.io/2018/07/17/Swift项目打点/)

