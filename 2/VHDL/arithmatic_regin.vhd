-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
ENTITY arithmatic_regin IS
  generic ( N : integer ) ;
   PORT
   (
        clk: IN STD_LOGIC;
		  input1,input2 : in std_logic_vector(N-1 downto 0) ; 
        code: in std_logic_vector(2 downto 0);
		  input1out: out  std_logic_vector(N-1 downto 0) ; 
		  input2out: out  std_logic_vector(N-1 downto 0) ; 
		  codeout: out std_logic_vector(2 downto 0)
   );
END arithmatic_regin;
architecture arch of arithmatic_regin is 
 -- signal tmp: std_logic_vector(7 downto 0); 
  begin 
    process (clk) 
      begin  
        if (clk'event and clk='1') then 
				     input1out<=input1;
				      input2out<=input2;
			         codeout<=code;
		     end if;
		  end process;
		  end arch;
