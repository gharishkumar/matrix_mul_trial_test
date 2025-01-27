from math import log2, ceil

# Functions for converting decimal to binary formats
def decimal_to_binary(decimal_float):
    """Convert a decimal floating-point number to binary floating-point representation."""
    if decimal_float < 0:
        sign = "-"
        decimal_float = -decimal_float
    else:
        sign = ""

    # Split into integer and fractional parts
    integer_part = int(decimal_float)
    fractional_part = decimal_float - integer_part

    # Convert the integer part to binary
    binary_integer = bin(integer_part).replace("0b", "")

    # Convert the fractional part to binary
    binary_fraction = []
    while fractional_part > 0 and len(binary_fraction) < 23:  # Limit to 23 bits for precision
        fractional_part *= 2
        if fractional_part >= 1:
            binary_fraction.append("1")
            fractional_part -= 1
        else:
            binary_fraction.append("0")

    binary_fraction = "".join(binary_fraction)
    return sign + binary_integer + "." + binary_fraction

def normalize_binary(binary_float):
    if '.' in binary_float:
        int_part, frac_part = binary_float.split('.')
    else:
        int_part, frac_part = binary_float, '0'

    sign_bit = '0'
    if binary_float.startswith('-'):
        sign_bit = '1'
        int_part = int_part[1:]

    # Normalize the binary number
    if int(int_part) > 0:
        first_one_pos = len(int_part) - 1
        normalized = int_part + frac_part
        exponent = first_one_pos
    else:
        first_one_pos = frac_part.find('1') + 1
        normalized = frac_part[first_one_pos:]
        exponent = -first_one_pos

    return sign_bit, normalized, exponent

def binary_to_ieee754(binary_float):
    sign_bit, normalized, exponent = normalize_binary(binary_float)

    # Adjust normalized number
    mantissa = normalized[1:24]  # 23 bits for mantissa
    mantissa += '0' * (23 - len(mantissa))

    # Calculate the biased exponent
    biased_exponent = exponent + 127
    exponent_bits = f"{biased_exponent:08b}"

    ieee754_binary = sign_bit + exponent_bits + mantissa
    return ieee754_binary

def binary_to_bfloat16(binary_float):
    sign_bit, normalized, exponent = normalize_binary(binary_float)

    # Adjust normalized number
    mantissa = normalized[1:8]  # 7 bits for mantissa
    mantissa += '0' * (7 - len(mantissa))

    # Calculate the biased exponent
    biased_exponent = exponent + 127
    exponent_bits = f"{biased_exponent:08b}"

    bfloat16_binary = sign_bit + exponent_bits + mantissa
    return bfloat16_binary

def binary_to_bfloat8(binary_float):
    sign_bit, normalized, exponent = normalize_binary(binary_float)

    # Adjust normalized number
    mantissa = normalized[1:3]  # 2 bits for mantissa
    mantissa += '0' * (2 - len(mantissa))

    # Calculate the biased exponent
    biased_exponent = exponent + 15
    exponent_bits = f"{biased_exponent:05b}"

    bfloat8_binary = sign_bit + exponent_bits + mantissa
    return bfloat8_binary

# Function to write Verilog code for BRAM
def write_bram_verilog(name, data, word_size=32):
    # Prepare output file
    file_name = name + ".v"
    with open(file_name, 'w') as f:
        # Get dimensions of the data
        size = len(data)

        # Calculate row and column width for address space
        addr_width = ceil(log2(size))

        # Write beginning part of module
        f.write(f"`timescale 1ns/1ps\n\n")
        f.write(f"module {name}_bram_rom\n")
        f.write(f"    (\n        input wire clk,\n        input wire [{addr_width - 1}:0] addr,\n        output reg [{word_size - 1}:0] data_out\n    );\n\n")
        f.write(f"    (* rom_style = \"block\" *)\n\n")
        f.write(f"    // Memory array\n")
        f.write(f"    reg [{word_size - 1}:0] rom [0:{size - 1}];\n\n")

        # Initialize ROM with data
        f.write(f"    initial begin\n")
        for addr, value in enumerate(data):
            f.write(f"        rom[{addr}] = {word_size}'b{value};\n")
        f.write(f"    end\n\n")

        # Read data from ROM on clock edge
        f.write(f"    always @(posedge clk) begin\n")
        f.write(f"        data_out <= rom[addr];\n")
        f.write(f"    end\n\n")

        f.write(f"endmodule")

# Main Program
def generate_bram(name, numbers, format_choice):
    data = []

    # Convert each number based on format choice
    for decimal_float in numbers:
        binary_float = decimal_to_binary(decimal_float)

        if format_choice == 1:  # IEEE 754 single precision
            binary_output = binary_to_ieee754(binary_float)
        elif format_choice == 2:  # bfloat16
            binary_output = binary_to_bfloat16(binary_float)
        elif format_choice == 3:  # bfloat8
            binary_output = binary_to_bfloat8(binary_float)
        else:
            raise ValueError("Invalid format choice")

        data.append(binary_output)

    # Write the BRAM Verilog module to file
    write_bram_verilog(name, data, word_size=32 if format_choice == 1 else (16 if format_choice == 2 else 8))

    print(f"Decimal floating-point numbers: {numbers}")
    print(f"Generated Verilog module saved to {name}.v")

# Driver function
def main():
    # Take 8 numbers as input for two 2x2 matrices
    print("Enter the elements of the first 2x2 matrix:")
    matrix1 = [
        float(input("Enter element [0][0]: ")),
        float(input("Enter element [0][1]: ")),
        float(input("Enter element [1][0]: ")),
        float(input("Enter element [1][1]: "))
    ]

    print("Enter the elements of the second 2x2 matrix:")
    matrix2 = [
        float(input("Enter element [0][0]: ")),
        float(input("Enter element [0][1]: ")),
        float(input("Enter element [1][0]: ")),
        float(input("Enter element [1][1]: "))
    ]

    numbers = matrix1 + matrix2

    # Select output format
    print("Select output format:")
    print("1. IEEE 754 single precision")
    print("2. bfloat 16")
    print("3. bfloat 8")
    format_choice = int(input("Enter your choice (1/2/3): "))

    # Generate Verilog module for BRAM
    generate_bram("io_bram", numbers, format_choice)

if __name__ == "__main__":
    main()
