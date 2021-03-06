# Pipeline
Verilog Code for the 5-stage pipeline CPU project in the course EI332, SJTU, 2020 Spring

## 设计说明
本设计包含外围设备，10个SW对应两个输入端口，6个HEX对应三个输出端口

进行了数据冒险和控制冒险的硬件处理，汇编代码相比单周期无需更改

实验期末测试使用此设计获得了正确结果

## 文件说明
sc_datamem.mif 与 sc_instmem.mif 在source文件夹中, sc_instmem_IO.mif 为验证IO扩展所用代码

pipelined_computer_test_wave_01.vwf 为流水线核心功能仿真波形, 输入开关SW0-9均设为0

pipelined_computer_test_wave_02.vwf 为IO仿真波形，输入开关实现了in_port输入数据每隔120ns加一


## 关键信号说明
wpcir：使pc和IF停顿一个周期(lw指令需要)

flush：当ID阶段检测到pcsource不为0，IF阶段已取出的指令需要被冲刷，本设计思路是将此信号给到IF/ID寄存器，再输出给下一阶段ID，ID初始时判断该信号是否为高，若为高将指令置为全零，实现冲刷


## Reference
https://github.com/cmciris/PipelinedCPU
