module pwm(
    input wire clk,          // System clock
    input wire rst,          // Active high reset
    input wire [3:0] duty_cycle, // 4-bit duty cycle input (0-15)
    output reg pwm_out       // PWM output signal
);

    reg [3:0] counter; // 4-bit counter
    reg [3:0] prev_duty_cycle; // Stores previous duty cycle value

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 4'b0;
            pwm_out <= 1'b0;
            prev_duty_cycle <= duty_cycle;
        end else begin
            if (duty_cycle != prev_duty_cycle) begin
                counter <= 4'b0; // Reset counter when duty cycle changes
                prev_duty_cycle <= duty_cycle;
            end else begin
                counter <= counter + 4'b1;
            end
            pwm_out <= (counter < duty_cycle) ? 1'b1 : 1'b0;
        end
    end

endmodule
