/*================================================
Thomas Gorham
ECE 441 Spring 2017
Project 2 - alu
Description: This module implements a 4-bit input
8-bit output synchronous ALU with clocked inputs
and outputs.
================================================*/
`timescale 100 ns / 1 ns

module alu(clk, mode, ar, A, B, SC);
  /*======================================
  Parameters
  ======================================*/

  /*======================================
  Input/Output Declaration
  ======================================*/
  input clk, ar;
  input [1:0] mode;
  input signed [3:0] A, B;

  output reg signed [7:0] SC;

  /*======================================
  Internal wires/registers
  ======================================*/
  reg signed [7:0] AC, BC; // Clocked in versions of A and B
  wire signed [7:0] S; // Unclocked internal copy of S
  wire signed [7:0] sum, sub, mult; // Internal asynchronous math

  /*======================================
  Asynchronous Logic
  ======================================*/
  assign sum = AC+BC;
  assign sub = AC-BC;
  assign mult = AC*BC;

  assign S = (mode == 2'b00)? sum: // Mode is 00: Do addition
            ((mode == 2'b01)? sub: // Mode is 01: Do subtraction
                              mult); // Mode is 10 or 11: Do multiplication

  /*======================================
  Synchronous Logic
  ======================================*/
  always @ (posedge clk or negedge ar)
    begin
      if(~ar)
        begin
          SC <= 8'sb00000000; // Output all zeroes. 
                             // It'll just get wiped as soon as AR is high again
        end
      else
        begin
          // Clock in inputs
          AC <= {{4{A[3]}}, A}; // Manually extend sign as internally,
          BC <= {{4{B[3]}}, B}; // we store A,B as 8-bit numbers
                                // This supresses warnings in the +,-,* operators
          // Clock out output
          SC <= S;
        end
    end
endmodule