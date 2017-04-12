/*================================================
Thomas Gorham

ECE 441 Spring 2017
Project 2 - Main

Description: This module instantiates all the
component modules used in this design.
================================================*/
`timescale 100 ns / 1 ns

module tld(
          clk, ar, a0, a1, a2, a3, b0, b1, b2, b3, m0, m1, sign,
          sa1, sb1, sc1, sd1, se1, sf1, sg1,
          sa2, sb2, sc2, sd2, se2, sf2, sg2
          );
  /*======================================
  Parameters
  ======================================*/

  /*======================================
  Input/Output Declaration
  ======================================*/
  input clk, ar, a0, a1, a2, a3, b0, b1, b2, b3, m0, m1;
  output sign;
  output sa1, sb1, sc1, sd1, se1, sf1, sg1;
  output sa2, sb2, sc2, sd2, se2, sf2, sg2;

  /*======================================
  Internal wires/registers
  ======================================*/
  wire [7:0] result;
  wire [3:0] dig0, dig1;

  /*======================================
  Module Instantiation
  ======================================*/
  alu alu0 (.clk(clk), .mode({m1, m0}), .ar(ar), .A({a3,a2,a1,a0}), .B({b3,b2,b1,b0}), .SC(result));
  
  bytedecoder bytedecoder0 (.num(result), .d0(dig0), .d1(dig1), .sign(sign));

  sevseg_decoder decoder0 (.val(dig0), .a(sa1), .b(sb1), .c(sc1), .d(sd1), .e(se1), .f(sf1), .g(sg1));
  sevseg_decoder decoder1 (.val(dig1), .a(sa2), .b(sb2), .c(sc2), .d(sd2), .e(se2), .f(sf2), .g(sg2));
endmodule
