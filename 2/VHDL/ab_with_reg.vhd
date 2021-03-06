
-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--entity properties

  entity ab_with_reg is 
  generic ( N : integer:=32 ) ; 
   port (en: in std_logic; a : in std_logic_vector(N-1 downto 0); clk: in std_logic ;d: out std_logic_vector(N-1 downto 0)) ; 
  end ab_with_reg ;
  
  architecture struct of ab_with_reg is
 
  --compoment declertaion
  component ab is 
  generic ( N : integer ) ; 
  port (a : in std_logic_vector(N-1 downto 0); d:out std_logic_vector(N-1 downto 0) ) ; 
  end component ; 

  component ab_regin is 
  generic ( N : integer ) ; 
  PORT
   (
       clk,en: IN STD_LOGIC;
-----------------------------------------------		  
		 
		  a_in: IN STD_LOGIC_vector(N-1 downto 0);
---------------------------------------------------		  
		
		  a_out: out STD_LOGIC_vector(N-1 downto 0)
   );
  end component;
  
  component ab_regout is 
  generic ( N : integer ) ; 
 PORT
   (
      clk,en: IN STD_LOGIC;
--------------------------------------------	  
		d_in: IN STD_LOGIC_vector(N-1 downto 0);
		
---------------------------------------------------		 
      d_out: out STD_LOGIC_vector(N-1 downto 0)

   );
 end component;
  
signal a_sig: std_logic_vector(N-1 downto 0);
signal d_sig: std_logic_vector(N-1 downto 0);
--signal status_sig: std_logic_vector (5 downto 0);

begin
--port mapping to all units
Gate1: ab_regin
generic map (N=>N)
port map (a_in=>a, clk=>clk, en=>en, a_out=>a_sig);
Gate2: ab 
generic map (N=>N)
port map (a=>a_sig, d=>d_sig);  
Gate3: ab_regout
generic map (N=>N)
port map (en=>en, clk=>clk, d_in=>d_sig, d_out=>d);


end struct;

