之前尝试例化dsp48e1的时候，google百度都解决不了问题，直接拿dsp48e1的代码来仿，这样还更快一点，

加了如下中间变量的打印，如果结果不如预期，可以观察这些变量，继续跟踪哪步结果异常，
a_o_mux根据A_INPUT=DIRECT还是CASCADE 选择a_in,还是acin_in
qd_o_mux 根据DREG，选择d_in还是延迟一周期的d_in
ad_addsub, 顾名思义，就是选择A+D,还是A-D
直接上代码更直观一点
assign ad_addsub = qinmode_o_mux[3]?(-a_preaddsub + (qinmode_o_mux[2]?qd_o_mux:25'b0)):(a_preaddsub + (qinmode_o_mux[2]?qd_o_mux:25'b0));

qad_o_mux 根据ADREG=0还是1，选择ad_addsub还是延迟一周期的ad_addsub
mult_o就是上面图中(A+D)*B的结果，即M

qopmode_o_mux，根据OPMODEREG，选择opmode_in还是延迟1周期的opmode_in
qx_o_mux，上图中X的选择，选择M，还是A:B,还是P

alu_o差不多最终的结果了，直接看代码更容易理解

qp_o_mux，根据PREG选择alu_o还是alu_o延迟1周期

qc_o_mux，根据CREG选择c_in还是c_in延迟1周期

qz_o_mux,第三个表格中Z的选择


下面是之前我调试时的打印，把.USE_DPORT误设为TRUE时，结果为0，可以看到mult_o这一步为0了，再跟着代码拉几根信号到波形窗口，就发现问题了,


run 1us
#                    0 a_o_mux[24:0]        x
#                    0 ADREG1 qad_o_mux        0
#                    0 ALU qx_o_mux               x qx_o_mux               x qz_o_mux               0
#                    0 qopmode_o_mux[1:0] 1 qx_o_mux               x
#                    0 ALU qx_o_mux               x qx_o_mux               0 qz_o_mux               0
#               200000 a_o_mux[24:0]      100
#               200000 ad_addsub[24:0]      100 qinmode_o_mux[3] 0 a_preaddsub[24:0]      100 qinmode_o_mux[2] 0 qd_o_mux[24:0]        0
#               200000 a_preaddsub[24:0]      100 qinmode_o_mux[1] 0 qinmode_o_mux[0] 0 qa_o_reg1[24:0]        0 qa_o_mux[24:0]      100
#               200000 qopmode_o_mux[1:0] 1 qx_o_mux               x
#               200000 mult_o             0
#               200000 qopmode_o_mux[1:0] 1 qx_o_mux               x
#               200000 ALU qx_o_mux               0 qx_o_mux               0 qz_o_mux               0
#               200000 alu_o               0
#               200001 qopmode_o_mux[1:0] 1 qx_o_mux               0
# p                0

