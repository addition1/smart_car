# smart_car
今天整理电脑文件发现了去年做毕业设计的代码，分享给大家，互相学习。EP4CE6E22C8核心板做控制核心，底板用的三轮结构车体、L298N电机驱动、两个直流减速电机，传感器用了红外遥控模块、四路红外探测模块、HC-SR04超声波模块，12v的锂电池组给L298N供电，外接AMS1117-5.0降压电源模块给核心板供电。实现的功能有红外遥控运动控制功能、红外循迹功能、超声波避障功能、红外跟随功能、小车三级调速功能、模式切换功能。
1.par文件夹是工程文件夹，里面有烧写用到的jic文件
2.rtl文件夹里是Verilog语言写的.v文件
3.sim文件夹存放各个功能单独仿真的测试文件
