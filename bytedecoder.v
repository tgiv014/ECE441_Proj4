/*================================================
Thomas Gorham
ECE 441 Spring 2017
Project 2 - bytedecoder
Description: This module implements a simple
8-bit to 2-digit binary to hex conversion for
input to the sevseg_decoder module.
================================================*/
`timescale 100 ns / 1 ns

module bytedecoder(num, d0, d1, sign);
  /*======================================
  Parameters
  ======================================*/
  parameter led_on = 1'b0;
  parameter led_off = 1'b1;

  /*======================================
  Input/Output Declaration
  ======================================*/
  input signed [7:0] num;

  output [3:0] d0, d1;
  output sign; // 1 bit to drive LED for sign

  /*======================================
  Internal wires/registers
  ======================================*/
  wire [7:0] mag; // Keep an internal value for whole-byte magnitude

  /*======================================
  Asynchronous Logic
  ======================================*/
  // If bit 7 is a 1 (negative input), convert to positive num
  assign mag = (num[7]==1)? (~num+1):(num);
  assign sign = (num[7]==1)? led_on:led_off;

  assign d0 = mag[3:0]; // D0 is lower half-byte (nibble)
  assign d1 = mag[7:4]; // D1 is upper

  /*======================================
  Synchronous Logic
  ======================================*/

endmodule