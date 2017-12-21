library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;
	use IEEE.std_logic_unsigned.all;
	use IEEE.numeric_std.all;
library lib_simon;
	use lib_simon.const_def.all;

entity counter is
	port(	
		clk	: in std_logic;
    nrst: in std_logic;
    done : out std_logic;	-- overflow flag
		count : out std_logic_vector(5 downto 0) --count output
	);
end counter;

architecture rtl_counter of counter is
	signal val: std_logic_vector(5 downto 0); --signal for read and write count value

begin
	process(clk,nrst)      
  begin
  	if (nrst = '0')  then -- asynchronous low level reset
	  	val <= "000000";		-- reset counter
     	done <= '0';				-- lower flag
    elsif clk'event and clk = '1' then
  	  if (val >= NB_ROUND)then  
      	val <= "111111"; 	-- stop counting
        done <='1';  		 	-- rise flag
      else 
      	val <= val + "000001"; --count
        done <='0';						 --lower flag
      end if;
    end if;
  end process;

  count <= val; 			--concurrential update of count output

end rtl_counter;