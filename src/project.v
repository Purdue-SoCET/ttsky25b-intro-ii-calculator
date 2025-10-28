/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_intro_ii_calculator (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  assign uio_oe = '1;  // Will use ALL bidirectional pins as outputs

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, ui_in[7:4], uio_in, 1'b0};

  // Instantiate project
  calculator_top calc_proj (
    .clk(clk),
    .nRST(rst_n),
    .RowIn(ui_in[3:0]),
    .ColOut(uo_out[3:0]),
    .display_output({uio_out, uo_out[7:4]}),
    .input_state_FPGA(),
    .key_pressed(),
    .complete()
  );

endmodule
