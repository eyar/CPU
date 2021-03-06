-- ====================================================================
--
--	File Name:		ALU.vhd
--	Description:alu top level entity 
--					
--
--	Date:			07/04/13
--	Designer:		yuval goldman & tal siton
--
-- ===================================================================


-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--entity properties

  entity alu_with_reg is 
  generic ( N : integer :=32 ) ; 
  port ( 
  input1_top,input2_top : in std_logic_vector(N-1 downto 0); 
  op_top: in std_logic_vector(3 downto 0) ; 
  clk: in std_logic ; 
  output_hi_top: out std_logic_vector(N-1 downto 0); 
  output_lo_top: out std_logic_vector(N-1 downto 0); 
  status_top: out std_logic_vector(5 downto 0));
  end alu_with_reg ;
  
  architecture struct of alu_with_reg is
 
  --compoment declertaion
  
   component ALU is 
   generic ( N : integer ) ; 
   port ( 
   input1,input2 : in std_logic_vector(N-1 downto 0); 
   op: in std_logic_vector(3 downto 0) ; 
   clk: in std_logic ; 
   output_hi: out std_logic_vector(N-1 downto 0); 
   output_lo: out std_logic_vector(N-1 downto 0); 
   status: out std_logic_vector(5 downto 0));
   end component ;
  
  
   component reg_in_alu is
   generic (N : integer) ;
   port ( 
   reg_a_in: in std_logic_vector(N-1 downto 0) :=(others=>'0'); 
   reg_b_in: in std_logic_vector(N-1 downto 0) :=(others=>'0'); 
   reg_op_in: in std_logic_vector(3 downto 0) :=(others=>'0'); 
   --en: in std_logic :='0';
	clk : in std_logic;
   reg_a_out: out std_logic_vector(N-1 downto 0) :=(others=>'0') ;
   reg_b_out: out std_logic_vector(N-1 downto 0) :=(others=>'0') ;
   reg_op_out: out std_logic_vector(3 downto 0) :=(others=>'0')  
   );
   end component ;
	
  component reg_out_alu is
  generic (N : integer) ;
  port ( 
  reg_out_a_in: in std_logic_vector(N-1 downto 0) :=(others=>'0'); 
  reg_out_b_in: in std_logic_vector(N-1 downto 0) :=(others=>'0'); 
  reg_out_stat_in: in std_logic_vector(5 downto 0) :=(others=>'0'); 
  --en: in std_logic :='0';
  clk : in std_logic;
  reg_out_a_out: out std_logic_vector(N-1 downto 0) :=(others=>'0') ;
  reg_out_b_out: out std_logic_vector(N-1 downto 0) :=(others=>'0') ;
  reg_out_stat_out: out std_logic_vector(5 downto 0) :=(others=>'0')  
  );
  end component ;

  
 

signal reg_a_to_alu_in: std_logic_vector(N-1 downto 0);
signal reg_b_to_alu_in: std_logic_vector(N-1 downto 0);  
signal reg_op_to_alu_in: std_logic_vector(3 downto 0);
signal alu_to_reg_a_out: std_logic_vector(N-1 downto 0);
signal alu_to_reg_b_out: std_logic_vector(N-1 downto 0);  
signal alu_to_reg_stat_out: std_logic_vector(5 downto 0);



begin
--port mapping to all units

Gate1: ALU
generic map (N=>N)
port map (
input1=>reg_a_to_alu_in,
input2=>reg_b_to_alu_in,
op=>reg_op_to_alu_in,
clk=>clk,
output_lo=>alu_to_reg_b_out,
output_hi=>alu_to_reg_a_out,
status=>alu_to_reg_stat_out
 );
 
 Gate2: reg_in_alu
generic map (N=>N)
port map (
reg_a_in=>input1_top,
reg_b_in=>input2_top,
reg_op_in=>op_top,
--en=>'1',
clk=>clk,
reg_a_out=>reg_a_to_alu_in,
reg_b_out=>reg_b_to_alu_in,
reg_op_out=>reg_op_to_alu_in
 );
 

 Gate3: reg_out_alu
generic map (N=>N)
port map (
reg_out_a_in=>alu_to_reg_a_out,
reg_out_b_in=>alu_to_reg_b_out,
reg_out_stat_in=>alu_to_reg_stat_out,
--en=>'1',
clk=>clk,
reg_out_a_out=>output_lo_top,
reg_out_b_out=>output_hi_top,
reg_out_stat_out=>status_top

 );
 




end struct;




