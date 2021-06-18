`timescale 1ns / 10ps // timescale time_unit/time_presicion



module test(
    input wire clk,
    input wire rst,
    input wire signed [24:0] in1,
    input wire signed [17:0] in2,

    output wire signed [47:0]  o,
    output wire signed [29:0] acout,
    output wire signed [17:0] bcout,
    output wire [3:0] carryout,
    output wire [3:0] carrycasout,
    output wire signed [47:0] pcout
);



DSP48E1 #(
.A_INPUT("DIRECT"),
.B_INPUT("DIRECT"),
.USE_DPORT("FALSE"),
.USE_MULT("MULTIPLY"),
.USE_SIMD("ONE48"),

.AUTORESET_PATDET("NO_RESET"),    // "NO_RESET", "RESET_MATCH", "RESET_NOT_MATCH"
.MASK(48'h3fffffffffff),          // 48-bit mask value for pattern detect (1=ignore)
.PATTERN(48'h000000000000),       // 48-bit pattern match for pattern detect
.SEL_MASK("MASK"),           // "C", "MASK", "ROUNDING_MODE1", "ROUNDING_MODE2"
.SEL_PATTERN("PATTERN"),          // Select pattern value ("PATTERN" or "C")
.USE_PATTERN_DETECT("NO_PATDET"),  // Enable pattern detect ("PATDET" or "NO_PATDET")

// Register Control Attributes: Pipeline Register Configuration
.ACASCREG(0),            //
.ADREG(1),               // Number of pipeline stages for pre-adder (0 or 1)

.ALUMODEREG(0),          // Number of pipeline stages for ALUMODE (0 or 1)

.AREG(0),                 // Number of pipeline stages for A (0, 1 or 2)  

.BCASCREG(0),            // Number of pipeline stages between B/BCIN and BCOUT (0, 1 or 2)

.BREG(0),                         // Number of pipeline stages for B (0, 1 or 2)

.CARRYINREG(0),                   // Number of pipeline stages for CARRYIN (0 or 1)
.CARRYINSELREG(0),                // Number of pipeline stages for CARRYINSEL (0 or 1)
.CREG(1),                         // Number of pipeline stages for C (0 or 1)
.DREG(1),                         // Number of pipeline stages for D (0 or 1)
.INMODEREG(0),                    // Number of pipeline stages for INMODE (0 or 1)
.MREG(0),                         // Number of multiplier pipeline stages (0 or 1)  还有这里变0，仅此2处变化
.OPMODEREG(0),                    // Number of pipeline stages for OPMODE (0 or 1)
.PREG(0)                          // Number of pipeline stages for P (0 or 1)

//CREG,DREG,ADREG实际没有用到，这些设为1其实也无意义

   )
DSP48E1_inst (
// Cascade: 30-bit (each) output: Cascade Ports
.ACOUT(acout),                   // 30-bit output: A port cascade output
.BCOUT(bcout),                   // 18-bit output: B port cascade output
.CARRYCASCOUT(carrycasout),     // 1-bit output: Cascade carry output
.MULTSIGNOUT(),       // 1-bit output: Multiplier sign cascade output
.PCOUT(pcout),                   // 48-bit output: Cascade output
//这些引脚空着就好
 
// Control: 1-bit (each) output: Control Inputs/Status Bits
.OVERFLOW(),             // 1-bit output: Overflow in add/acc output
.PATTERNBDETECT(),        // 1-bit output: Pattern bar detect output
.PATTERNDETECT(),   // 1-bit output: Pattern detect output
.UNDERFLOW(),           // 1-bit output: Underflow in add/acc output
//这些引脚也空着，没用
 
// Data: 4-bit (each) output: Data Ports
.CARRYOUT(carryout),                               // 4-bit output: Carry output
.P(o),                           // 48-bit output: Primary data output
//P输出48bit的
 
// Cascade: 30-bit (each) input: Cascade Ports
.ACIN(30'b0),                     // 30-bit input: A cascade data input
.BCIN(18'b0),                     // 18-bit input: B cascade input
.CARRYCASCIN(1'b0),              // 1-bit input: Cascade carry input
.MULTSIGNIN(1'b0),         // 1-bit input: Multiplier sign input
.PCIN(48'b0),                     // 48-bit input: P cascade input
//这些引脚很重要，做流水线时，数据又这几个引脚输入。
 
// Control: 4-bit (each) input: Control Inputs/Status Bits
.ALUMODE(4'b0),               // 4-bit input: ALU control input
.CARRYINSEL(3'b0),         // 3-bit input: Carry select input
.CLK(clk),                       // 1-bit input: Clock input                //assign这里变0
.INMODE(5'b0),                 // 5-bit input: INMODE control input
.OPMODE(7'b0000101),                 // 7-bit input: Operation mode input

 
// Data: 30-bit (each) input: Data Ports
.A(in1),                           // 30-bit input: A data input
.B(in2),                           // 18-bit input: B data input
.C(48'hffffffffffff),              // 48-bit input: C data input
.CARRYIN(1'b0),                      // 1-bit input: Carry input signal
.D(25'b0),                           // 25-bit input: D data input

 
// Reset/Clock Enable: 1-bit (each) input: Reset/Clock Enable Inputs
.CEA1(1'b0),                      // 1-bit input: Clock enable input for 1st stage AREG
.CEA2(1'b0),                      // 1-bit input: Clock enable input for 2nd stage AREG
.CEAD(1'b0),                      // 1-bit input: Clock enable input for ADREG
.CEALUMODE(1'b0),                 // 1-bit input: Clock enable input for ALUMODE
.CEB1(1'b0),                      // 1-bit input: Clock enable input for 1st stage BREG
.CEB2(1'b0),                      // 1-bit input: Clock enable input for 2nd stage BREG
.CEC(1'b0),                       // 1-bit input: Clock enable input for CREG
.CECARRYIN(1'b0),                 // 1-bit input: Clock enable input for CARRYINREG
.CECTRL(1'b0),                    // 1-bit input: Clock enable input for OPMODEREG and CARRYINSELREG
.CED(1'b0),                       // 1-bit input: Clock enable input for DREG
.CEINMODE(1'b0),                  // 1-bit input: Clock enable input for INMODEREG
.CEM(1'b0),                       // 1-bit input: Clock enable input for MREG
.CEP(1'b0),                       // 1-bit input: Clock enable input for PREG

.RSTA(1'b0),                       // 1-bit input: Reset input for AREG
.RSTALLCARRYIN(1'b0),              // 1-bit input: Reset input for CARRYINREG
.RSTALUMODE(1'b0),                 // 1-bit input: Reset input for ALUMODEREG
.RSTB(1'b0),                       // 1-bit input: Reset input for BREG
.RSTC(1'b0),                       // 1-bit input: Reset input for CREG
.RSTCTRL(1'b0),                    // 1-bit input: Reset input for OPMODEREG and CARRYINSELREG
.RSTD(1'b0),                       // 1-bit input: Reset input for DREG and ADREG
.RSTINMODE(1'b0),                  // 1-bit input: Reset input for INMODEREG
.RSTM(1'b0),                       // 1-bit input: Reset input for MREG
.RSTP(1'b0)                        // 1-bit input: Reset input for PREG
);

endmodule

module bitstream_tb;
reg rst;
reg dec_clk;

reg signed [24:0] a;
reg signed [17:0] b;
reg signed [47:0] d;
reg signed [47:0] c;

wire signed [47:0] p;

wire signed [29:0] ac;
wire signed [17:0] bc;
wire [3:0] co;
wire [3:0] ccas;
wire signed [47:0] pc;

initial begin
    rst = 0;
    #200 a = 100;
    #0 b = 200;
    #0 d = 45;
    #0 c = 400;
    #50 rst = 1;
    #1 rst = 0;


    #100 $display("p %d",p);
end

always
begin
    #1 dec_clk = 0;
    #1 dec_clk = 1;
end

test test_inst(
.clk(dec_clk),
.rst(rst),
.in1(a),
.in2(b),

.o(p),
.acout(ac),
.bcout(bc),
.carryout(co),
.carrycasout(ccas),
.pcout(pc)
);




endmodule