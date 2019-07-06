--------------------------------------------------------------------------------
--| File name   : $RCSfile: io1164.vhd $
--| Library     : SUPPORT
--| Revision    : $Revision: 1.1 $
--| Author(s)   : Vantage Analysis Systems, Inc; Des Young
--| Integration : Des Young
--| Creation    : Nov 1995
--| Status      : $State: Exp $
--|
--| Purpose     : IO routines for std_logic_1164.
--| Assumptions : Numbers use radixed character set with no prefix.
--| Limitations : Does not read VHDL pound-radixed numbers.
--| Known Errors: none
--|
--| Description:
--| This is a modified library. The source is basically that donated by
--| Vantage to libutil. Des Young removed std_ulogic_vector support (to
--| conform to synthesizable libraries), and added read_oct/hex to integer.
--|
--| =======================================================================
--| Copyright (c) 1992-1994 Vantage Analysis Systems, Inc., all rights
--| reserved. This package is provided by Vantage Analysis Systems.
--| The package may not be sold without the express written consent of
--| Vantage Analysis Systems, Inc.
--|
--| The VHDL for this package may be copied and/or distributed as long as
--| this copyright notice is retained in the source and any modifications
--| are clearly marked in the History: list.
--|
--| Title       : IO1164 package VHDL source
--| Package Name: somelib.IO1164
--| File Name   : io1164.vhdl
--| Author(s)   : dbb
--| Purpose     : * Overloads procedures READ and WRITE for STD_LOGIC types
--|                 in manner consistent with TEXTIO package.
--|               * Provides procedures to read and write logic values as
--|                 binary, octal, or hexadecimal values ('X' as appropriate).
--|                 These should be particularly useful for models
--|                 to read in stimulus as 0/1/x or octal or hex.
--| Subprograms :
--| Notes       : 
--| History     : 1. Donated to libutil by Dave Bernstein 15 Jun 94
--|               2. Removed all std_ulogic_vector support, Des Young, 14 Nov 95
--|                  (This is because that type is not supported for synthesis).
--|               3. Added read_oct/hex to integer, Des Young, 20 Nov 95
--|
--| =======================================================================
--| Extra routines by Des Young, des@alantec.com. 1995. GNU copyright.
--| =======================================================================
--|
--------------------------------------------------------------------------------

library ieee;
package io1164 is

    --$ !VANTAGE_METACOMMENTS_ON
    --$ !VANTAGE_DNA_ON

    -- import std_logic package
    use ieee.std_logic_1164.all;

    -- import textio package
    use std.textio.all;

    --
    -- the READ and WRITE procedures act similarly to the procedures in the
    -- STD.TEXTIO package.  for each type, there are two read procedures and
    -- one write procedure for converting between character and internal
    -- representations of values.  each value is represented as the string of
    -- characters that you would use in VHDL code.  (remember that apostrophes
    -- and quotation marks are not used.)  input is case-insensitive.  output
    -- is in upper case.  see the following LRM sections for more information:
    --
    --      2.3   - Subprogram Overloading
    --      3.3   - Access Types             (STD.TEXTIO.LINE is an access type)
    --      7.3.6 - Allocators               (allocators create access values)
    --     14.3   - Package TEXTIO
    --

    -- Note that the procedures for std_ulogic will match calls with the value
    -- parameter of type std_logic.

    --
    -- declare READ procedures to overload like in TEXTIO
    --
    procedure read(l: inout line; value: out std_ulogic       ; good: out boolean);
    procedure read(l: inout line; value: out std_ulogic                          );
    procedure read(l: inout line; value: out std_logic_vector ; good: out boolean);
    procedure read(l: inout line; value: out std_logic_vector                    );

    --
    -- declare WRITE procedures to overload like in TEXTIO
    --
    procedure write(l        : inout line                  ;
                    value    : in    std_ulogic            ;
                    justified: in    side          := right;
                    field    : in    width         := 0   );
    procedure write(l        : inout line                  ;
                    value    : in    std_logic_vector      ;
                    justified: in    side          := right;
                    field    : in    width         := 0   );

    --
    -- declare procedures to convert between logic values and octal
    -- or hexadecimal ('X' where appropriate).
    --

    -- octal / std_logic_vector
    procedure read_oct (l         : inout line                    ;
                        value     : out   std_logic_vector        ;
                        good      : out   boolean                );
    procedure read_oct (l         : inout line                    ;
                        value     : out   std_logic_vector       );
    procedure write_oct(l         : inout line                    ;
                        value     : in    std_logic_vector        ;
                        justified : in    side            := right;
                        field     : in    width           := 0   );

    -- hexadecimal / std_logic_vector
    procedure read_hex (l         : inout line                    ;
                        value     : out   std_logic_vector        ;
                        good      : out   boolean                );
    procedure read_hex (l         : inout line                    ;
                        value     : out   std_logic_vector       );
    procedure write_hex(l         : inout line                    ;
                        value     : in    std_logic_vector        ;
                        justified : in    side            := right;
                        field     : in    width           := 0   );

    -- read a number into an integer
    procedure read_oct(l     : inout line;
                       value : out   integer;
                       good  : out   boolean);
    procedure read_oct(l     : inout line;
                       value : out   integer);
    procedure read_hex(l     : inout line;
                       value : out   integer;
                       good  : out   boolean);
    procedure read_hex(l     : inout line;
                       value : out   integer);

end io1164;

--------------------------------------------------------------------------------
--| Copyright (c) 1992-1994 Vantage Analysis Systems, Inc., all rights reserved
--| This package is provided by Vantage Analysis Systems.
--| The package may not be sold without the express written consent of
--| Vantage Analysis Systems, Inc.
--|
--| The VHDL for this package may be copied and/or distributed as long as
--| this copyright notice is retained in the source and any modifications
--| are clearly marked in the History: list.
--|
--| Title       : IO1164 package body VHDL source
--| Package Name: VANTAGE_LOGIC.IO1164
--| File Name   : io1164.vhdl
--| Author(s)   : dbb
--| Purpose     : source for IO1164 package body
--| Subprograms :
--| Notes       : see package declaration
--| History     : see package declaration
--------------------------------------------------------------------------------

package body io1164 is


    --$ !VANTAGE_METACOMMENTS_ON
    --$ !VANTAGE_DNA_ON

    -- define lowercase conversion of characters for canonical comparison
    type char2char_t is array (character'low to character'high) of character;
    constant lowcase: char2char_t := (
        nul, soh, stx, etx, eot, enq, ack, bel,
        bs,  ht,  lf,  vt,  ff,  cr,  so,  si,
        dle, dc1, dc2, dc3, dc4, nak, syn, etb,
        can, em,  sub, esc, fsp, gsp, rsp, usp, 

        ' ', '!', '"', '#', '$', '%', '&', ''',
        '(', ')', '*', '+', ',', '-', '.', '/',
        '0', '1', '2', '3', '4', '5', '6', '7',
        '8', '9', ':', ';', '<', '=', '>', '?',

        '@', 'a', 'b', 'c', 'd', 'e', 'f', 'g',
        'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
        'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
        'x', 'y', 'z', '[', '\', ']', '^', '_',

        '`', 'a', 'b', 'c', 'd', 'e', 'f', 'g',
        'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
        'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
        'x', 'y', 'z', '{', '|', '}', '~', del);

    -- define conversions between various types

    -- logic    -> character
    type f_logic_to_character_t is 
        array (std_ulogic'low to std_ulogic'high) of character;
    constant f_logic_to_character : f_logic_to_character_t := 
        ( 
          'U' => 'U', 
          'X' => 'X',
          '0' => '0',
          '1' => '1',
          'Z' => 'Z',
          'W' => 'W',
          'L' => 'L',
          'H' => 'H',
          '-' => '-'
        );

    -- character, integer, logic

    constant x_charcode     : integer := -1;
    constant maxoct_charcode: integer := 7;
    constant maxhex_charcode: integer := 15;
    constant bad_charcode   : integer := integer'left;

    type digit2int_t is 
        array ( character'low to character'high ) of integer;
    constant octdigit2int: digit2int_t := (
          '0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4,
          '5' => 5, '6' => 6, '7' => 7,
          'X' | 'x' => x_charcode, others => bad_charcode );
    constant hexdigit2int: digit2int_t := (
          '0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4,
          '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9, 
          'A' | 'a' => 10, 'B' | 'b' => 11, 'C' | 'c' => 12,
          'D' | 'd' => 13, 'E' | 'e' => 14, 'F' | 'f' => 15,
          'X' | 'x' => x_charcode, others => bad_charcode  );

    constant oct_bits_per_digit: integer := 3;
    constant hex_bits_per_digit: integer := 4;

    type     int2octdigit_t is 
        array ( 0 to maxoct_charcode ) of character;
    constant int2octdigit: int2octdigit_t :=
        (  0 => '0',  1 => '1',  2 => '2',  3 => '3',
           4 => '4',  5 => '5',  6 => '6',  7 => '7' );

    type     int2hexdigit_t is 
        array ( 0 to maxhex_charcode ) of character;
    constant int2hexdigit: int2hexdigit_t :=
        (  0 => '0',  1 => '1',  2 => '2',  3 => '3',
           4 => '4',  5 => '5',  6 => '6',  7 => '7',
           8 => '8',  9 => '9', 10 => 'A', 11 => 'B',
          12 => 'C', 13 => 'D', 14 => 'E', 15 => 'F' );

    type     oct_logic_vector_t is
        array(1 to oct_bits_per_digit) of std_ulogic;
    type     octint2logic_t is 
        array (x_charcode to maxoct_charcode) of oct_logic_vector_t;
    constant octint2logic  : octint2logic_t := (
        ( 'X', 'X', 'X' ),
        ( '0', '0', '0' ),
        ( '0', '0', '1' ),
        ( '0', '1', '0' ),
        ( '0', '1', '1' ),
        ( '1', '0', '0' ),
        ( '1', '0', '1' ),
        ( '1', '1', '0' ),
        ( '1', '1', '1' )
    );

    type     hex_logic_vector_t is
        array(1 to hex_bits_per_digit) of std_ulogic;
    type     hexint2logic_t is 
        array (x_charcode to maxhex_charcode) of hex_logic_vector_t;
    constant hexint2logic  : hexint2logic_t := (
        ( 'X', 'X', 'X', 'X' ),
        ( '0', '0', '0', '0' ),
        ( '0', '0', '0', '1' ),
        ( '0', '0', '1', '0' ),
        ( '0', '0', '1', '1' ),
        ( '0', '1', '0', '0' ),
        ( '0', '1', '0', '1' ),
        ( '0', '1', '1', '0' ),
        ( '0', '1', '1', '1' ),
        ( '1', '0', '0', '0' ),
        ( '1', '0', '0', '1' ),
        ( '1', '0', '1', '0' ),
        ( '1', '0', '1', '1' ),
        ( '1', '1', '0', '0' ),
        ( '1', '1', '0', '1' ),
        ( '1', '1', '1', '0' ),
        ( '1', '1', '1', '1' )
    );

    ----------------------------------------------------------------------------
    -- READ procedure bodies
    --
    --     The strategy for duplicating TEXTIO's overloading of procedures
    --     with and without GOOD parameters is to put all the logic in the
    --     version with the GOOD parameter and to have the version without
    --     GOOD approximate a runtime error by use of an assertion.
    --
    ----------------------------------------------------------------------------

    --
    -- std_ulogic
    --     note: compatible with std_logic
    --

    procedure read( l: inout line; value: out std_ulogic; good : out boolean ) is

        variable c      : character;        -- char read while looping
        variable m      : line;             -- safe copy of L
        variable success: boolean := false; -- readable version of GOOD
        variable done   : boolean := false; -- flag to say done reading chars

    begin

        --
        -- algorithm:
        -- 
        --     if there are characters in the line
        --         save a copy of the line
        --         get the next character
        --         if got one
        --             set value
        --         if all ok
        --             free temp copy
        --         else
        --             free passed in line
        --             assign copy back to line
        --         set GOOD
        --     

        -- only operate on lines that contain characters
        if ( ( l /= null ) and ( l.all'length /= 0 ) ) then

            -- save a copy of string in case read fails
            m := new string'( l.all );
    
            -- grab the next character
            read( l, c, success );

            -- if read ok    
            if success then

--
-- an issue here is whether lower-case values should be accepted or not
--

                -- determine the value    
                case c is
                    when 'U' | 'u' => value := 'U';
                    when 'X' | 'x' => value := 'X';
                    when '0'       => value := '0';
                    when '1'       => value := '1';
                    when 'Z' | 'z' => value := 'Z';
                    when 'W' | 'w' => value := 'W';
                    when 'L' | 'l' => value := 'L';
                    when 'H' | 'h' => value := 'H';
                    when '-'       => value := '-';
                    when others    => success := false;
                end case;

            end if;

            -- free working storage
            if success then
                deallocate( m );
            else
                deallocate( l );
                l := m;
            end if;

        end if; -- non null access, non empty string

        -- set output parameter
        good := success;

    end read;

    procedure read( l: inout line; value: out std_ulogic ) is
        variable success: boolean;  -- internal good flag
    begin
        read( l, value, success );  -- use safe version
        assert success 
            report "IO1164.READ: Unable to read STD_ULOGIC value." 
            severity error;
    end read;

    --
    -- std_logic_vector
    --     note: NOT compatible with std_ulogic_vector
    --

    procedure read(l    : inout line           ; 
                   value: out   std_logic_vector;
                   good : out   boolean        ) is

        variable m           : line           ; -- saved copy of L
        variable success     : boolean := true; -- readable GOOD
        variable logic_value : std_logic      ; -- value for one array element
        variable c           : character      ; -- read a character

    begin

        --
        -- algorithm:
        -- 
        --     this procedure strips off leading whitespace, and then calls the
        --     READ procedure for each single logic value element in the output
        --     array.
        --     

        -- only operate on lines that contain characters
        if ( ( l /= null ) and ( l.all'length /= 0 ) ) then

            -- save a copy of string in case read fails
            m := new string'( l.all );

            -- loop for each element in output array
            for i in value'range loop

                -- prohibit internal blanks
                if i /= value'left then
                    if l.all'length = 0 then
                        success := false;
                        exit;
                    end if;
                    c := l.all(l.all'left);
                    if c = ' ' or c = ht then
                        success := false;
                        exit;
                    end if;
                end if;

                -- read the next logic value
                read( l, logic_value, success );

                -- stuff the value in if ok, else bail out
                if success then
                    value( i ) := logic_value;
                else
                    exit;
                end if;

            end loop; -- each element in output array

            -- free working storage
            if success then
                deallocate( m );
            else
                deallocate( l );
                l := m;
            end if;

        elsif ( value'length /= 0 ) then
            -- string is empty but the  return array has 1+ elements
            success := false;
        end if;

        -- set output parameter
        good := success;

    end read;

    procedure read(l: inout line; value: out std_logic_vector ) is
        variable success: boolean;
    begin
        read( l, value, success );
        assert success 
            report "IO1164.READ: Unable to read T_WLOGIC_VECTOR value." 
            severity error;
    end read;

    ----------------------------------------------------------------------------
    -- WRITE procedure bodies
    ----------------------------------------------------------------------------

    --
    -- std_ulogic
    --     note: compatible with std_logic
    --

    procedure write(l        : inout line          ;
                    value    : in    std_ulogic    ;
                    justified: in    side  := right;
                    field    : in    width := 0    ) is
    begin

        --
        -- algorithm:
        -- 
        --     just write out the string associated with the enumerated
        --     value.
        --     

        case value is
            when 'U' => write( l, character'('U'), justified, field );
            when 'X' => write( l, character'('X'), justified, field );
            when '0' => write( l, character'('0'), justified, field );
            when '1' => write( l, character'('1'), justified, field );
            when 'Z' => write( l, character'('Z'), justified, field );
            when 'W' => write( l, character'('W'), justified, field );
            when 'L' => write( l, character'('L'), justified, field );
            when 'H' => write( l, character'('H'), justified, field );
            when '-' => write( l, character'('-'), justified, field );
        end case;
    end write;

    --
    -- std_logic_vector
    --     note: NOT compatible with std_ulogic_vector
    --

    procedure write(l        : inout line                   ;
                    value    : in    std_logic_vector       ;
                    justified: in    side           := right;
                    field    : in    width          := 0    ) is

        variable m: line; -- build up intermediate string

    begin

        --
        -- algorithm:
        -- 
        --     for each value in array
        --         add string representing value to intermediate string
        --     write intermediate string to line parameter
        --     free intermediate string
        --     

        -- for each value in array
        for i in value'range loop

            -- add string representing value to intermediate string
            write( m, value( i ) );

        end loop;

        -- write intermediate string to line parameter
        write( l, m.all, justified, field );

        -- free intermediate string
        deallocate( m );

    end write;


--------------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    -- procedure bodies for octal and hexadecimal read and write
    ----------------------------------------------------------------------------

    --
    -- std_logic_vector/octal
    --     note: NOT compatible with std_ulogic_vector
    --

    procedure read_oct(l         : inout line            ; 
                       value     : out   std_logic_vector; 
                       good      : out   boolean         ) is

        variable m               : line                      ; -- safe L
        variable success         : boolean            := true; -- readable GOOD
        variable logic_value     : std_logic                 ; -- elem value
        variable c               : character                 ; -- char read
        variable charcode        : integer                   ; -- char->int
        variable oct_logic_vector: oct_logic_vector_t        ; -- for 1 digit
        variable bitpos          : integer                   ; -- in state vec.
    begin

        --
        -- algorithm:
        -- 
        --     skip over leading blanks, then read a digit
        --     and do a conversion into a logic value
        --     for each element in array
        --     

        -- make sure logic array is right size to read this base
        success := ( ( value'length rem oct_bits_per_digit ) = 0 );
        if success then

            -- only operate on non-empty strings
            if ( ( l /= null ) and ( l.all'length /= 0 ) ) then

                -- save old copy of string in case read fails
                m := new string'( l.all );

                -- pick off leading white space and get first significant char
                c := ' ';
                while success and ( l.all'length > 0 ) and ( ( c = ' ' ) or ( c = ht ) ) loop
                    read( l, c, success );
                end loop;

                -- turn character into integer
                charcode := octdigit2int( c );

                -- not doing any bits yet
                bitpos := 0;

                -- check for bad first character
                if charcode = bad_charcode then
                    success := false;
                else
                    -- loop through each value in array
                    oct_logic_vector := octint2logic( charcode );
                    for i in value'range loop
    
                        -- doing the next bit
                        bitpos := bitpos + 1;
    
                        -- stick the value in
                        value( i ) := oct_logic_vector( bitpos );
                        
                        -- read the next character if we're not at array end
                        if ( bitpos = oct_bits_per_digit ) and ( i /= value'right ) then
                            read( l, c, success );
                            if not success then
                                exit;
                            end if;
                            -- turn character into integer
                            charcode := octdigit2int( c );
                            -- check for bad char
                            if charcode = bad_charcode then
                                success := false;
                                exit;
                            end if;
                            -- reset bit position
                            bitpos := 0;
                            -- turn character code into state array 
                            oct_logic_vector := octint2logic( charcode );
                        end if;
                        
                    end loop; -- each index in return array
 
                end if; -- if bad first character

                -- clean up working storage
                if success then
                    deallocate( m );
                else
                    deallocate( l );
                    l := m;
                end if;

            -- no characters to read for return array that isn't null slice
            elsif ( value'length /= 0 ) then
                success := false;
            end if; -- non null access, non empty string

        end if;

        -- set out parameter of success
        good := success;

    end read_oct;


    procedure read_oct(l         : inout line            ; 
                       value     : out   std_logic_vector) is
        variable success: boolean;                 -- internal good flag
    begin                                                              
        read_oct( l, value, success ); -- use safe version  
        assert success 
            report "IO1164.READ_OCT: Unable to read T_LOGIC_VECTOR value." 
            severity error;
    end read_oct;

    procedure write_oct(l        : inout line                   ;
                        value    : in    std_logic_vector       ;
                        justified: in    side           := right;
                        field    : in    width          := 0    ) is

        variable m            : line     ; -- safe copy of L
        variable goodlength   : boolean  ; -- array is ok len for this base
        variable isx          : boolean  ; -- an X in this digit
        variable integer_value: integer  ; -- accumulate integer value
        variable c            : character; -- character read
        variable charpos      : integer  ; -- index string being contructed
        variable bitpos       : integer  ; -- bit index inside digit

    begin

        --
        -- algorithm:
        -- 
        -- make sure this array can be written in this base
        -- create a string to place intermediate results
        -- initialize counters and flags to beginning of string
        -- for each item in array
        --     note unknown, else accumulate logic into integer
        --         if at this digit's last bit
        --             stuff digit just computed into intermediate result
        --             reset flags and counters except for charpos
        -- write intermediate result into line
        -- free work storage
        --     

        -- make sure this array can be written in this base
        goodlength := ( ( value'length rem oct_bits_per_digit ) = 0 );
        assert goodlength
            report "IO1164.WRITE_OCT: VALUE'Length is not a multiple of 3."
            severity error;
        if goodlength then

            -- create a string to place intermediate results
            m := new string(1 to ( value'length / oct_bits_per_digit ) );

            -- initialize counters and flags to beginning of string
            charpos := 0;
            bitpos := 0;
            isx := false;
            integer_value := 0;

            -- for each item in array
            for i in value'range loop

                -- note unknown, else accumulate logic into integer
                case value(i) is
                    when '0' | 'L' =>
                        integer_value := integer_value * 2;
                    when '1' | 'H' =>
                        integer_value := ( integer_value * 2 ) + 1;
                    when others =>
                        isx := true;
                end case;

                -- see if we've done this digit's last bit
                bitpos := bitpos + 1;
                if bitpos = oct_bits_per_digit then

                    -- stuff the digit just computed into the intermediate result
                    charpos := charpos + 1;
                    if isx then
                        m.all(charpos) := 'X';
                    else
                        m.all(charpos) := int2octdigit( integer_value );
                    end if;

                    -- reset flags and counters except for location in string being constructed
                    bitpos := 0;
                    isx := false;
                    integer_value := 0;

                end if;

            end loop;

            -- write intermediate result into line
            write( l, m.all, justified, field );

            -- free work storage
            deallocate( m );

        end if;

    end write_oct;

    --
    -- std_logic_vector/hexadecimal
    --     note: NOT compatible with std_ulogic_vector
    --

    procedure read_hex(l         : inout line            ; 
                       value     : out   std_logic_vector; 
                       good      : out   boolean         ) is

        variable m               : line                      ; -- safe L
        variable success         : boolean            := true; -- readable GOOD
        variable logic_value     : std_logic                 ; -- elem value
        variable c               : character                 ; -- char read
        variable charcode        : integer                   ; -- char->int
        variable hex_logic_vector: hex_logic_vector_t        ; -- for 1 digit
        variable bitpos          : integer                   ; -- in state vec.
    begin

        --
        -- algorithm:
        -- 
        --     skip over leading blanks, then read a digit
        --     and do a conversion into a logic value
        --     for each element in array
        --     

        -- make sure logic array is right size to read this base
        success := ( ( value'length rem hex_bits_per_digit ) = 0 );
        if success then

            -- only operate on non-empty strings
            if ( ( l /= null ) and ( l.all'length /= 0 ) ) then

                -- save old copy of string in case read fails
                m := new string'( l.all );

                -- pick off leading white space and get first significant char
                c := ' ';
                while success and ( l.all'length > 0 ) and ( ( c = ' ' ) or ( c = ht ) ) loop
                    read( l, c, success );
                end loop;

                -- turn character into integer
                charcode := hexdigit2int( c );

                -- not doing any bits yet
                bitpos := 0;

                -- check for bad first character
                if charcode = bad_charcode then
                    success := false;
                else
                    -- loop through each value in array
                    hex_logic_vector := hexint2logic( charcode );
                    for i in value'range loop
    
                        -- doing the next bit
                        bitpos := bitpos + 1;
    
                        -- stick the value in
                        value( i ) := hex_logic_vector( bitpos );
                        
                        -- read the next character if we're not at array end
                        if ( bitpos = hex_bits_per_digit ) and ( i /= value'right ) then
                            read( l, c, success );
                            if not success then
                                exit;
                            end if;
                            -- turn character into integer
                            charcode := hexdigit2int( c );
                            -- check for bad char
                            if charcode = bad_charcode then
                                success := false;
                                exit;
                            end if;
                            -- reset bit position
                            bitpos := 0;
                            -- turn character code into state array 
                            hex_logic_vector := hexint2logic( charcode );
                        end if;
                        
                    end loop; -- each index in return array
 
                end if; -- if bad first character

                -- clean up working storage
                if success then
                    deallocate( m );
                else
                    deallocate( l );
                    l := m;
                end if;

            -- no characters to read for return array that isn't null slice
            elsif ( value'length /= 0 ) then
                success := false;
            end if; -- non null access, non empty string

        end if;

        -- set out parameter of success
        good := success;

    end read_hex;


    procedure read_hex(l         : inout line            ; 
                       value     : out   std_logic_vector) is
        variable success: boolean;                 -- internal good flag
    begin                                                              
        read_hex( l, value, success ); -- use safe version  
        assert success 
            report "IO1164.READ_HEX: Unable to read T_LOGIC_VECTOR value." 
            severity error;
    end read_hex;

    procedure write_hex(l        : inout line                   ;
                        value    : in    std_logic_vector       ;
                        justified: in    side           := right;
                        field    : in    width          := 0    ) is

        variable m            : line     ; -- safe copy of L
        variable goodlength   : boolean  ; -- array is ok len for this base
        variable isx          : boolean  ; -- an X in this digit
        variable integer_value: integer  ; -- accumulate integer value
        variable c            : character; -- character read
        variable charpos      : integer  ; -- index string being contructed
        variable bitpos       : integer  ; -- bit index inside digit

    begin

        --
        -- algorithm:
        -- 
        -- make sure this array can be written in this base
        -- create a string to place intermediate results
        -- initialize counters and flags to beginning of string
        -- for each item in array
        --     note unknown, else accumulate logic into integer
        --         if at this digit's last bit
        --             stuff digit just computed into intermediate result
        --             reset flags and counters except for charpos
        -- write intermediate result into line
        -- free work storage
        --     

        -- make sure this array can be written in this base
        goodlength := ( ( value'length rem hex_bits_per_digit ) = 0 );
        assert goodlength
            report "IO1164.WRITE_HEX: VALUE'Length is not a multiple of 4."
            severity error;
        if goodlength then

            -- create a string to place intermediate results
            m := new string(1 to ( value'length / hex_bits_per_digit ) );

            -- initialize counters and flags to beginning of string
            charpos := 0;
            bitpos := 0;
            isx := false;
            integer_value := 0;

            -- for each item in array
            for i in value'range loop

                -- note unknown, else accumulate logic into integer
                case value(i) is
                    when '0' | 'L' =>
                        integer_value := integer_value * 2;
                    when '1' | 'H' =>
                        integer_value := ( integer_value * 2 ) + 1;
                    when others =>
                        isx := true;
                end case;

                -- see if we've done this digit's last bit
                bitpos := bitpos + 1;
                if bitpos = hex_bits_per_digit then

                    -- stuff the digit just computed into the intermediate result
                    charpos := charpos + 1;
                    if isx then
                        m.all(charpos) := 'X';
                    else
                        m.all(charpos) := int2hexdigit( integer_value );
                    end if;

                    -- reset flags and counters except for location in string being constructed
                    bitpos := 0;
                    isx := false;
                    integer_value := 0;

                end if;

            end loop;

            -- write intermediate result into line
            write( l, m.all, justified, field );

            -- free work storage
            deallocate( m );

        end if;

    end write_hex;

------------------------------------------------------------------------------

    ------------------------------------
    -- Read octal/hex numbers to integer
    ------------------------------------

    --
    -- Read octal to integer
    --
    
    procedure read_oct(l     : inout line;
                       value : out integer;
                       good  : out boolean) is

        variable pos     : integer;
        variable digit   : integer;
        variable result  : integer := 0;
        variable success : boolean := true;
        variable c       : character;
        variable old_l   : line := l;

    begin
        -- algorithm:
        --
        --  skip leading white space, read digit, convert
        --  into integer
        --
        if (l /= NULL) then
            -- set pos to start of actual number by skipping white space
            pos := l'LEFT;
            c := l(pos);
            while ( l.all'length > 0 ) and ( ( c = ' ' ) or ( c = HT ) ) loop
                pos := pos + 1;
                c := l(pos);
            end loop;
            
            -- check for start of valid number
            digit := octdigit2int(l(pos));

            if ((digit = bad_charcode) or (digit = x_charcode)) then
                good := FALSE;
                return;
            else
                -- calculate integer value
                for i in pos to l'RIGHT loop
                    digit := octdigit2int(l(pos));
                    exit when (digit = bad_charcode) or (digit = x_charcode);
                    result := (result * 8) + digit;
                    pos := pos + 1;
                end loop;
                value := result;
                -- shrink line
                if (pos > 1) then
                    l := new string'(old_l(pos to old_l'HIGH));
                    deallocate(old_l);
                end if;
                good := TRUE;
                return;
            end if;
        else
            good := FALSE;
        end if;

    end read_oct;

    -- simple version
    procedure read_oct(l     : inout line;
                       value : out   integer) is

        variable success: boolean;                 -- internal good flag

    begin                                                              
        read_oct( l, value, success ); -- use safe version  
        assert success 
            report "IO1164.READ_OCT: Unable to read octal integer value." 
            severity error;
    end read_oct;


    --
    -- Read hex to integer
    --
    
    procedure read_hex(l     : inout line;
                       value : out integer;
                       good  : out boolean) is

        variable pos     : integer;
        variable digit   : integer;
        variable result  : integer := 0;
        variable success : boolean := true;
        variable c       : character;
        variable old_l   : line := l;

    begin
        -- algorithm:
        --
        --  skip leading white space, read digit, convert
        --  into integer
        --
        if (l /= NULL) then
            -- set pos to start of actual number by skipping white space
            pos := l'LEFT;
            c := l(pos);
            while ( l.all'length > 0 ) and ( ( c = ' ' ) or ( c = HT ) ) loop
                pos := pos + 1;
                c := l(pos);
            end loop;
            
            -- check for start of valid number
            digit := hexdigit2int(l(pos));

            if ((digit = bad_charcode) or (digit = x_charcode)) then
                good := FALSE;
                return;
            else
                -- calculate integer value
                for i in pos to l'RIGHT loop
                    digit := hexdigit2int(l(pos));
                    exit when (digit = bad_charcode) or (digit = x_charcode);
                    result := (result * 16) + digit;
                    pos := pos + 1;
                end loop;
                value := result;
                -- shrink line
                if (pos > 1) then
                    l := new string'(old_l(pos to old_l'HIGH));
                    deallocate(old_l);
                end if;
                good := TRUE;
                return;
            end if;
        else
            good := FALSE;
        end if;

    end read_hex;

    -- simple version
    procedure read_hex(l     : inout line;
                       value : out   integer) is

        variable success: boolean;                 -- internal good flag

    begin                                                              
        read_hex( l, value, success ); -- use safe version  
        assert success 
            report "IO1164.READ_HEX: Unable to read hex integer value." 
            severity error;
    end read_hex;

end io1164;
