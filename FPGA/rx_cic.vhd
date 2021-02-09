-- -------------------------------------------------------------
--
-- Module: rx_cic
-- Generated by MATLAB(R) 9.9 and Filter Design HDL Coder 3.1.8.
-- Generated on: 2021-02-08 21:54:52
-- -------------------------------------------------------------

-- -------------------------------------------------------------
-- HDL Code Generation Options:
--
-- TargetLanguage: VHDL
-- OptimizeForHDL: on
-- AddPipelineRegisters: on
-- Name: rx_cic
-- TestBenchName: rx_cic_tb
-- TestBenchStimulus: step ramp chirp noise 

-- -------------------------------------------------------------
-- HDL Implementation    : Fully parallel
-- -------------------------------------------------------------
-- Filter Settings:
--
-- Discrete-Time FIR Multirate Filter (real)
-- -----------------------------------------
-- Filter Structure    : Cascaded Integrator-Comb Decimator
-- Decimation Factor   : 640
-- Differential Delay  : 1
-- Number of Sections  : 6
-- Stable              : Yes
-- Linear Phase        : Yes (Type 1)
--
-- -------------------------------------------------------------



LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.ALL;

ENTITY rx_cic IS
   PORT( clk                             :   IN    std_logic; 
         clk_enable                      :   IN    std_logic; 
         reset                           :   IN    std_logic; 
         filter_in                       :   IN    std_logic_vector(30 DOWNTO 0); -- sfix31
         filter_out                      :   OUT   std_logic_vector(31 DOWNTO 0); -- sfix32_E55
         ce_out                          :   OUT   std_logic  
         );

END rx_cic;


----------------------------------------------------------------
--Module Architecture: rx_cic
----------------------------------------------------------------
ARCHITECTURE rtl OF rx_cic IS
  -- Local Functions
  -- Type Definitions
  -- Constants
  -- Signals
  SIGNAL cur_count                        : unsigned(9 DOWNTO 0); -- ufix10
  SIGNAL phase_1                          : std_logic; -- boolean
  SIGNAL ce_delayline                     : std_logic; -- boolean
  SIGNAL int_delay_pipe                   : std_logic_vector(0 TO 4); -- boolean
  SIGNAL ce_gated                         : std_logic; -- boolean
  SIGNAL ce_out_reg                       : std_logic; -- boolean
  --   
  SIGNAL input_register                   : signed(30 DOWNTO 0); -- sfix31
  --   -- Section 1 Signals 
  SIGNAL section_in1                      : signed(30 DOWNTO 0); -- sfix31
  SIGNAL section_cast1                    : signed(73 DOWNTO 0); -- sfix74_E13
  SIGNAL sum1                             : signed(73 DOWNTO 0); -- sfix74_E13
  SIGNAL section_out1                     : signed(73 DOWNTO 0); -- sfix74_E13
  SIGNAL add_cast                         : signed(73 DOWNTO 0); -- sfix74_E13
  SIGNAL add_cast_1                       : signed(73 DOWNTO 0); -- sfix74_E13
  SIGNAL add_temp                         : signed(74 DOWNTO 0); -- sfix75_E13
  --   -- Section 2 Signals 
  SIGNAL section_in2                      : signed(73 DOWNTO 0); -- sfix74_E13
  SIGNAL sum2                             : signed(73 DOWNTO 0); -- sfix74_E13
  SIGNAL section_out2                     : signed(73 DOWNTO 0); -- sfix74_E13
  SIGNAL add_cast_2                       : signed(73 DOWNTO 0); -- sfix74_E13
  SIGNAL add_cast_3                       : signed(73 DOWNTO 0); -- sfix74_E13
  SIGNAL add_temp_1                       : signed(74 DOWNTO 0); -- sfix75_E13
  --   -- Section 3 Signals 
  SIGNAL section_in3                      : signed(73 DOWNTO 0); -- sfix74_E13
  SIGNAL sum3                             : signed(73 DOWNTO 0); -- sfix74_E13
  SIGNAL section_out3                     : signed(73 DOWNTO 0); -- sfix74_E13
  SIGNAL add_cast_4                       : signed(73 DOWNTO 0); -- sfix74_E13
  SIGNAL add_cast_5                       : signed(73 DOWNTO 0); -- sfix74_E13
  SIGNAL add_temp_2                       : signed(74 DOWNTO 0); -- sfix75_E13
  --   -- Section 4 Signals 
  SIGNAL section_in4                      : signed(73 DOWNTO 0); -- sfix74_E13
  SIGNAL section_cast4                    : signed(58 DOWNTO 0); -- sfix59_E28
  SIGNAL sum4                             : signed(58 DOWNTO 0); -- sfix59_E28
  SIGNAL section_out4                     : signed(58 DOWNTO 0); -- sfix59_E28
  SIGNAL add_cast_6                       : signed(58 DOWNTO 0); -- sfix59_E28
  SIGNAL add_cast_7                       : signed(58 DOWNTO 0); -- sfix59_E28
  SIGNAL add_temp_3                       : signed(59 DOWNTO 0); -- sfix60_E28
  --   -- Section 5 Signals 
  SIGNAL section_in5                      : signed(58 DOWNTO 0); -- sfix59_E28
  SIGNAL section_cast5                    : signed(50 DOWNTO 0); -- sfix51_E36
  SIGNAL sum5                             : signed(50 DOWNTO 0); -- sfix51_E36
  SIGNAL section_out5                     : signed(50 DOWNTO 0); -- sfix51_E36
  SIGNAL add_cast_8                       : signed(50 DOWNTO 0); -- sfix51_E36
  SIGNAL add_cast_9                       : signed(50 DOWNTO 0); -- sfix51_E36
  SIGNAL add_temp_4                       : signed(51 DOWNTO 0); -- sfix52_E36
  --   -- Section 6 Signals 
  SIGNAL section_in6                      : signed(50 DOWNTO 0); -- sfix51_E36
  SIGNAL section_cast6                    : signed(42 DOWNTO 0); -- sfix43_E44
  SIGNAL sum6                             : signed(42 DOWNTO 0); -- sfix43_E44
  SIGNAL section_out6                     : signed(42 DOWNTO 0); -- sfix43_E44
  SIGNAL add_cast_10                      : signed(42 DOWNTO 0); -- sfix43_E44
  SIGNAL add_cast_11                      : signed(42 DOWNTO 0); -- sfix43_E44
  SIGNAL add_temp_5                       : signed(43 DOWNTO 0); -- sfix44_E44
  --   -- Section 7 Signals 
  SIGNAL section_in7                      : signed(42 DOWNTO 0); -- sfix43_E44
  SIGNAL section_cast7                    : signed(38 DOWNTO 0); -- sfix39_E48
  SIGNAL diff1                            : signed(38 DOWNTO 0); -- sfix39_E48
  SIGNAL section_out7                     : signed(38 DOWNTO 0); -- sfix39_E48
  SIGNAL sub_cast                         : signed(38 DOWNTO 0); -- sfix39_E48
  SIGNAL sub_cast_1                       : signed(38 DOWNTO 0); -- sfix39_E48
  SIGNAL sub_temp                         : signed(39 DOWNTO 0); -- sfix40_E48
  SIGNAL cic_pipeline7                    : signed(38 DOWNTO 0); -- sfix39_E48
  --   -- Section 8 Signals 
  SIGNAL section_in8                      : signed(38 DOWNTO 0); -- sfix39_E48
  SIGNAL section_cast8                    : signed(37 DOWNTO 0); -- sfix38_E49
  SIGNAL diff2                            : signed(37 DOWNTO 0); -- sfix38_E49
  SIGNAL section_out8                     : signed(37 DOWNTO 0); -- sfix38_E49
  SIGNAL sub_cast_2                       : signed(37 DOWNTO 0); -- sfix38_E49
  SIGNAL sub_cast_3                       : signed(37 DOWNTO 0); -- sfix38_E49
  SIGNAL sub_temp_1                       : signed(38 DOWNTO 0); -- sfix39_E49
  SIGNAL cic_pipeline8                    : signed(37 DOWNTO 0); -- sfix38_E49
  --   -- Section 9 Signals 
  SIGNAL section_in9                      : signed(37 DOWNTO 0); -- sfix38_E49
  SIGNAL section_cast9                    : signed(36 DOWNTO 0); -- sfix37_E50
  SIGNAL diff3                            : signed(36 DOWNTO 0); -- sfix37_E50
  SIGNAL section_out9                     : signed(36 DOWNTO 0); -- sfix37_E50
  SIGNAL sub_cast_4                       : signed(36 DOWNTO 0); -- sfix37_E50
  SIGNAL sub_cast_5                       : signed(36 DOWNTO 0); -- sfix37_E50
  SIGNAL sub_temp_2                       : signed(37 DOWNTO 0); -- sfix38_E50
  SIGNAL cic_pipeline9                    : signed(36 DOWNTO 0); -- sfix37_E50
  --   -- Section 10 Signals 
  SIGNAL section_in10                     : signed(36 DOWNTO 0); -- sfix37_E50
  SIGNAL section_cast10                   : signed(35 DOWNTO 0); -- sfix36_E51
  SIGNAL diff4                            : signed(35 DOWNTO 0); -- sfix36_E51
  SIGNAL section_out10                    : signed(35 DOWNTO 0); -- sfix36_E51
  SIGNAL sub_cast_6                       : signed(35 DOWNTO 0); -- sfix36_E51
  SIGNAL sub_cast_7                       : signed(35 DOWNTO 0); -- sfix36_E51
  SIGNAL sub_temp_3                       : signed(36 DOWNTO 0); -- sfix37_E51
  SIGNAL cic_pipeline10                   : signed(35 DOWNTO 0); -- sfix36_E51
  --   -- Section 11 Signals 
  SIGNAL section_in11                     : signed(35 DOWNTO 0); -- sfix36_E51
  SIGNAL diff5                            : signed(35 DOWNTO 0); -- sfix36_E51
  SIGNAL section_out11                    : signed(35 DOWNTO 0); -- sfix36_E51
  SIGNAL sub_cast_8                       : signed(35 DOWNTO 0); -- sfix36_E51
  SIGNAL sub_cast_9                       : signed(35 DOWNTO 0); -- sfix36_E51
  SIGNAL sub_temp_4                       : signed(36 DOWNTO 0); -- sfix37_E51
  SIGNAL cic_pipeline11                   : signed(35 DOWNTO 0); -- sfix36_E51
  --   -- Section 12 Signals 
  SIGNAL section_in12                     : signed(35 DOWNTO 0); -- sfix36_E51
  SIGNAL section_cast12                   : signed(34 DOWNTO 0); -- sfix35_E52
  SIGNAL diff6                            : signed(34 DOWNTO 0); -- sfix35_E52
  SIGNAL section_out12                    : signed(34 DOWNTO 0); -- sfix35_E52
  SIGNAL sub_cast_10                      : signed(34 DOWNTO 0); -- sfix35_E52
  SIGNAL sub_cast_11                      : signed(34 DOWNTO 0); -- sfix35_E52
  SIGNAL sub_temp_5                       : signed(35 DOWNTO 0); -- sfix36_E52
  SIGNAL output_typeconvert               : signed(31 DOWNTO 0); -- sfix32_E55
  --   
  SIGNAL output_register                  : signed(31 DOWNTO 0); -- sfix32_E55


BEGIN

  -- Block Statements
  --   ------------------ CE Output Generation ------------------

  ce_output : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      cur_count <= to_unsigned(0, 10);
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
        IF cur_count >= to_unsigned(639, 10) THEN
          cur_count <= to_unsigned(0, 10);
        ELSE
          cur_count <= cur_count + to_unsigned(1, 10);
        END IF;
      END IF;
    END IF; 
  END PROCESS ce_output;

  phase_1 <= '1' WHEN cur_count = to_unsigned(1, 10) AND clk_enable = '1' ELSE '0';

  ce_delay : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      int_delay_pipe <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_1 = '1' THEN
        int_delay_pipe(1 TO 4) <= int_delay_pipe(0 TO 3);
        int_delay_pipe(0) <= clk_enable;
      END IF;
    END IF;
  END PROCESS ce_delay;
  ce_delayline <= int_delay_pipe(4);

  ce_gated <=  ce_delayline AND phase_1;

  --   ------------------ CE Output Register ------------------

  ce_output_register : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      ce_out_reg <= '0';
    ELSIF clk'event AND clk = '1' THEN
      ce_out_reg <= ce_gated;
      
    END IF; 
  END PROCESS ce_output_register;

  --   ------------------ Input Register ------------------

  input_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_register <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
        input_register <= signed(filter_in);
      END IF;
    END IF; 
  END PROCESS input_reg_process;

  --   ------------------ Section # 1 : Integrator ------------------

  section_in1 <= input_register;

  section_cast1 <= resize(section_in1(30 DOWNTO 13), 74);

  add_cast <= section_cast1;
  add_cast_1 <= section_out1;
  add_temp <= resize(add_cast, 75) + resize(add_cast_1, 75);
  sum1 <= add_temp(73 DOWNTO 0);

  integrator_delay_section1 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      section_out1 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
        section_out1 <= sum1;
      END IF;
    END IF; 
  END PROCESS integrator_delay_section1;

  --   ------------------ Section # 2 : Integrator ------------------

  section_in2 <= section_out1;

  add_cast_2 <= section_in2;
  add_cast_3 <= section_out2;
  add_temp_1 <= resize(add_cast_2, 75) + resize(add_cast_3, 75);
  sum2 <= add_temp_1(73 DOWNTO 0);

  integrator_delay_section2 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      section_out2 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
        section_out2 <= sum2;
      END IF;
    END IF; 
  END PROCESS integrator_delay_section2;

  --   ------------------ Section # 3 : Integrator ------------------

  section_in3 <= section_out2;

  add_cast_4 <= section_in3;
  add_cast_5 <= section_out3;
  add_temp_2 <= resize(add_cast_4, 75) + resize(add_cast_5, 75);
  sum3 <= add_temp_2(73 DOWNTO 0);

  integrator_delay_section3 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      section_out3 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
        section_out3 <= sum3;
      END IF;
    END IF; 
  END PROCESS integrator_delay_section3;

  --   ------------------ Section # 4 : Integrator ------------------

  section_in4 <= section_out3;

  section_cast4 <= section_in4(73 DOWNTO 15);

  add_cast_6 <= section_cast4;
  add_cast_7 <= section_out4;
  add_temp_3 <= resize(add_cast_6, 60) + resize(add_cast_7, 60);
  sum4 <= add_temp_3(58 DOWNTO 0);

  integrator_delay_section4 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      section_out4 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
        section_out4 <= sum4;
      END IF;
    END IF; 
  END PROCESS integrator_delay_section4;

  --   ------------------ Section # 5 : Integrator ------------------

  section_in5 <= section_out4;

  section_cast5 <= section_in5(58 DOWNTO 8);

  add_cast_8 <= section_cast5;
  add_cast_9 <= section_out5;
  add_temp_4 <= resize(add_cast_8, 52) + resize(add_cast_9, 52);
  sum5 <= add_temp_4(50 DOWNTO 0);

  integrator_delay_section5 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      section_out5 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
        section_out5 <= sum5;
      END IF;
    END IF; 
  END PROCESS integrator_delay_section5;

  --   ------------------ Section # 6 : Integrator ------------------

  section_in6 <= section_out5;

  section_cast6 <= section_in6(50 DOWNTO 8);

  add_cast_10 <= section_cast6;
  add_cast_11 <= section_out6;
  add_temp_5 <= resize(add_cast_10, 44) + resize(add_cast_11, 44);
  sum6 <= add_temp_5(42 DOWNTO 0);

  integrator_delay_section6 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      section_out6 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
        section_out6 <= sum6;
      END IF;
    END IF; 
  END PROCESS integrator_delay_section6;

  --   ------------------ Section # 7 : Comb ------------------

  section_in7 <= section_out6;

  section_cast7 <= section_in7(42 DOWNTO 4);

  sub_cast <= section_cast7;
  sub_cast_1 <= diff1;
  sub_temp <= resize(sub_cast, 40) - resize(sub_cast_1, 40);
  section_out7 <= sub_temp(38 DOWNTO 0);

  comb_delay_section7 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      diff1 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_1 = '1' THEN
        diff1 <= section_cast7;
      END IF;
    END IF; 
  END PROCESS comb_delay_section7;

  cic_pipeline_process_section7 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      cic_pipeline7 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_1 = '1' THEN
        cic_pipeline7 <= section_out7;
      END IF;
    END IF; 
  END PROCESS cic_pipeline_process_section7;

  --   ------------------ Section # 8 : Comb ------------------

  section_in8 <= cic_pipeline7;

  section_cast8 <= section_in8(38 DOWNTO 1);

  sub_cast_2 <= section_cast8;
  sub_cast_3 <= diff2;
  sub_temp_1 <= resize(sub_cast_2, 39) - resize(sub_cast_3, 39);
  section_out8 <= sub_temp_1(37 DOWNTO 0);

  comb_delay_section8 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      diff2 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_1 = '1' THEN
        diff2 <= section_cast8;
      END IF;
    END IF; 
  END PROCESS comb_delay_section8;

  cic_pipeline_process_section8 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      cic_pipeline8 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_1 = '1' THEN
        cic_pipeline8 <= section_out8;
      END IF;
    END IF; 
  END PROCESS cic_pipeline_process_section8;

  --   ------------------ Section # 9 : Comb ------------------

  section_in9 <= cic_pipeline8;

  section_cast9 <= section_in9(37 DOWNTO 1);

  sub_cast_4 <= section_cast9;
  sub_cast_5 <= diff3;
  sub_temp_2 <= resize(sub_cast_4, 38) - resize(sub_cast_5, 38);
  section_out9 <= sub_temp_2(36 DOWNTO 0);

  comb_delay_section9 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      diff3 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_1 = '1' THEN
        diff3 <= section_cast9;
      END IF;
    END IF; 
  END PROCESS comb_delay_section9;

  cic_pipeline_process_section9 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      cic_pipeline9 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_1 = '1' THEN
        cic_pipeline9 <= section_out9;
      END IF;
    END IF; 
  END PROCESS cic_pipeline_process_section9;

  --   ------------------ Section # 10 : Comb ------------------

  section_in10 <= cic_pipeline9;

  section_cast10 <= section_in10(36 DOWNTO 1);

  sub_cast_6 <= section_cast10;
  sub_cast_7 <= diff4;
  sub_temp_3 <= resize(sub_cast_6, 37) - resize(sub_cast_7, 37);
  section_out10 <= sub_temp_3(35 DOWNTO 0);

  comb_delay_section10 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      diff4 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_1 = '1' THEN
        diff4 <= section_cast10;
      END IF;
    END IF; 
  END PROCESS comb_delay_section10;

  cic_pipeline_process_section10 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      cic_pipeline10 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_1 = '1' THEN
        cic_pipeline10 <= section_out10;
      END IF;
    END IF; 
  END PROCESS cic_pipeline_process_section10;

  --   ------------------ Section # 11 : Comb ------------------

  section_in11 <= cic_pipeline10;

  sub_cast_8 <= section_in11;
  sub_cast_9 <= diff5;
  sub_temp_4 <= resize(sub_cast_8, 37) - resize(sub_cast_9, 37);
  section_out11 <= sub_temp_4(35 DOWNTO 0);

  comb_delay_section11 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      diff5 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_1 = '1' THEN
        diff5 <= section_in11;
      END IF;
    END IF; 
  END PROCESS comb_delay_section11;

  cic_pipeline_process_section11 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      cic_pipeline11 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_1 = '1' THEN
        cic_pipeline11 <= section_out11;
      END IF;
    END IF; 
  END PROCESS cic_pipeline_process_section11;

  --   ------------------ Section # 12 : Comb ------------------

  section_in12 <= cic_pipeline11;

  section_cast12 <= section_in12(35 DOWNTO 1);

  sub_cast_10 <= section_cast12;
  sub_cast_11 <= diff6;
  sub_temp_5 <= resize(sub_cast_10, 36) - resize(sub_cast_11, 36);
  section_out12 <= sub_temp_5(34 DOWNTO 0);

  comb_delay_section12 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      diff6 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_1 = '1' THEN
        diff6 <= section_cast12;
      END IF;
    END IF; 
  END PROCESS comb_delay_section12;

  output_typeconvert <= section_out12(34 DOWNTO 3);

  --   ------------------ Output Register ------------------

  output_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      output_register <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_1 = '1' THEN
        output_register <= output_typeconvert;
      END IF;
    END IF; 
  END PROCESS output_reg_process;

  -- Assignment Statements
  ce_out <= ce_out_reg;
  filter_out <= std_logic_vector(output_register);
END rtl;