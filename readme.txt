֮ǰ��������dsp48e1��ʱ��google�ٶȶ�����������⣬ֱ����dsp48e1�Ĵ������£�����������һ�㣬

���������м�����Ĵ�ӡ������������Ԥ�ڣ����Թ۲���Щ���������������Ĳ�����쳣��
a_o_mux����A_INPUT=DIRECT����CASCADE ѡ��a_in,����acin_in
qd_o_mux ����DREG��ѡ��d_in�����ӳ�һ���ڵ�d_in
ad_addsub, ����˼�壬����ѡ��A+D,����A-D
ֱ���ϴ����ֱ��һ��
assign ad_addsub = qinmode_o_mux[3]?(-a_preaddsub + (qinmode_o_mux[2]?qd_o_mux:25'b0)):(a_preaddsub + (qinmode_o_mux[2]?qd_o_mux:25'b0));

qad_o_mux ����ADREG=0����1��ѡ��ad_addsub�����ӳ�һ���ڵ�ad_addsub
mult_o��������ͼ��(A+D)*B�Ľ������M

qopmode_o_mux������OPMODEREG��ѡ��opmode_in�����ӳ�1���ڵ�opmode_in
qx_o_mux����ͼ��X��ѡ��ѡ��M������A:B,����P

alu_o������յĽ���ˣ�ֱ�ӿ�������������

qp_o_mux������PREGѡ��alu_o����alu_o�ӳ�1����

qc_o_mux������CREGѡ��c_in����c_in�ӳ�1����

qz_o_mux,�����������Z��ѡ��


������֮ǰ�ҵ���ʱ�Ĵ�ӡ����.USE_DPORT����ΪTRUEʱ�����Ϊ0�����Կ���mult_o��һ��Ϊ0�ˣ��ٸ��Ŵ����������źŵ����δ��ڣ��ͷ���������,


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

