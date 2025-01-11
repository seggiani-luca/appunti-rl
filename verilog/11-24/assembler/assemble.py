import sys
import re
import copy

BASE_OFFSET = 0xF000

PARSE_TABLE = {
    "hlt": {"opcode": "00"},
    "nop": {"opcode": "09"},
    "mov": {
        ("%al", "%ah"): {"opcode": "0a"},
        ("%ah", "%al"): {"opcode": "0b"},
        ("$op", "%dp"): {"opcode": "22"},
        ("$op", "%sp"): {"opcode": "23"},
        ("adr", "%dp"): {"opcode": "24"},
        ("%dp", "adr"): {"opcode": "25"},
        ("(%dp)", "%al"): {"opcode": "40"},
        ("(%dp)", "%ah"): {"opcode": "46"},
        ("%al", "(%dp)"): {"opcode": "60"},
        ("%ah", "(%dp)"): {"opcode": "61"},
        ("$op", "%al"): {"opcode": "80"},
        ("$op", "%ah"): {"opcode": "86"},
        ("adr", "%al"): {"opcode": "a0"},
        ("adr", "%ah"): {"opcode": "a6"},
        ("%al", "adr"): {"opcode": "c0"},
        ("%ah", "adr"): {"opcode": "c1"}
    },
    "inc": {"opcode": "19"},
    "shl": {
        ("%al"): {"opcode": "06"},
        ("%ah"): {"opcode": "16"}
    },
    "shr": {
        ("%al"): {"opcode": "07"},
        ("%ah"): {"opcode": "17"}
    },
    "not": {
        ("%al"): {"opcode": "08"},
        ("%ah"): {"opcode": "18"}
    },
    "cmp": {
        ("%ah", "%al"): {"opcode": "01"},
        ("(%dp)", "%al"): {"opcode": "41"},
        ("$op", "%al"): {"opcode": "81"},
        ("adr", "%al"): {"opcode": "a1"},
        ("%al", "%ah"): {"opcode": "11"},
        ("(%dp)", "%ah"): {"opcode": "51"},
        ("$op", "%ah"): {"opcode": "91"},
        ("adr", "%ah"): {"opcode": "b1"}
    },
    "add": {
        ("%ah", "%al"): {"opcode": "02"},
        ("(%dp)", "%al"): {"opcode": "42"},
        ("$op", "%al"): {"opcode": "82"},
        ("adr", "%al"): {"opcode": "a2"},
        ("%al", "%ah"): {"opcode": "12"},
        ("(%dp)", "%ah"): {"opcode": "52"},
        ("$op", "%ah"): {"opcode": "92"},
        ("adr", "%ah"): {"opcode": "b2"}
    },
    "sub": {
        ("%ah", "%al"): {"opcode": "03"},
        ("(%dp)", "%al"): {"opcode": "43"},
        ("$op", "%al"): {"opcode": "83"},
        ("adr", "%al"): {"opcode": "a3"},
        ("%al", "%ah"): {"opcode": "13"},
        ("(%dp)", "%ah"): {"opcode": "53"},
        ("$op", "%ah"): {"opcode": "93"},
        ("adr", "%ah"): {"opcode": "b3"}
    },
    "and": {
        ("%ah", "%al"): {"opcode": "04"},
        ("(%dp)", "%al"): {"opcode": "44"},
        ("$op", "%al"): {"opcode": "84"},
        ("adr", "%al"): {"opcode": "a4"},
        ("%al", "%ah"): {"opcode": "14"},
        ("(%dp)", "%ah"): {"opcode": "54"},
        ("$op", "%ah"): {"opcode": "94"},
        ("adr", "%ah"): {"opcode": "b4"}
    },
    "or": {
        ("%ah", "%al"): {"opcode": "05"},
        ("(%dp)", "%al"): {"opcode": "45"},
        ("$op", "%al"): {"opcode": "85"},
        ("adr", "%al"): {"opcode": "a5"},
        ("%al", "%ah"): {"opcode": "15"},
        ("(%dp)", "%ah"): {"opcode": "55"},
        ("$op", "%ah"): {"opcode": "95"},
        ("adr", "%ah"): {"opcode": "b5"}
    },
    "push": {
        ("%al"): {"opcode": "1a"},
        ("%ah"): {"opcode": "1c"},
        ("%dp"): {"opcode": "1e"},
    },
    "pop": {
        ("%al"): {"opcode": "1b"},
        ("%ah"): {"opcode": "1d"},
        ("%dp"): {"opcode": "1f"},
    },
    "ret": {"opcode": "10"},
    "in": {"opcode": "20"},
    "out": {"opcode": "21"},
    "jmp": {"opcode": "e0"},
    "je": {"opcode": "e1"},
    "jne": {"opcode": "e2"},
    "ja": {"opcode": "e3"},
    "jae": {"opcode": "e4"},
    "jb": {"opcode": "e5"},
    "jbe": {"opcode": "e6"},
    "jg": {"opcode": "e7"},
    "jge": {"opcode": "e8"},
    "jl": {"opcode": "e9"},
    "jle": {"opcode": "ea"},
    "jz": {"opcode": "eb"},
    "jnz": {"opcode": "ec"},
    "jc": {"opcode": "ed"},
    "jnc": {"opcode": "ee"},
    "jo": {"opcode": "ef"},
    "jno": {"opcode": "f0"},
    "js": {"opcode": "f1"},
    "jns": {"opcode": "f2"},
    "call": {"opcode": "f3"}
}

labels = dict()


def tokenize(line):
    tokens = re.split(r"[ |,]", line)
    tokens = [tok for tok in tokens if tok]
    return tokens


def match(mnem, args, rule, l_num):
    if len(rule) == 1:
        return rule.get("opcode")

    t_args = copy.deepcopy(args)

    for i in range(len(t_args)):
        if t_args[i][0] == "$":
            t_args[i] = "$op"
        elif t_args[i][0] != "%" and t_args[i][0] != "(":
            t_args[i] = "adr"

    t_args = tuple(t_args)

    opcode = rule.get(t_args, None)
    if opcode:
        return opcode.get("opcode")
    else:
        print(f"Instruction '{mnem}' with given arguments not found at line {l_num}")
        exit()


def strip_args(args, l_num):
    if len(args) == 0:
        return []

    arg = args[0]

    if arg[0] == "%":
        return []

    if arg[0] == "$":
        arg = arg[1:]

    if arg[0] == "_":
        label = arg[1:]
        addr = labels.get(label)
        if addr:
            arg = addr
        else:
            print(f"Label {label} not found at line {l_num}")
            exit()

    if len(arg) == 1 or len(arg) == 3:
        arg = "0" + arg

    if len(arg) == 4:
        arg_l = arg[2:4]
        arg_h = arg[0:2]
        return [arg_l, arg_h]

    return [arg]


def assemble(in_file, out_file):
    byte = 0
    l_num = 0

    for line in in_file:
        line = line.strip()
        l_num = l_num + 1

        if not line:
            continue

        tokens = tokenize(line)

        mnem = tokens[0]
        args = tokens[1:]

        if mnem[0] == "_":
            # label
            if mnem[len(mnem) - 1] != ":":
                print(f"Label must terminate in ':' at line {l_num}")

            label = mnem[1:len(mnem) - 1]
            label_offset = hex(byte + BASE_OFFSET)[2:]

            print(f"// {label} ({label_offset})", file=out_file)

            labels[label] = label_offset
        else:
            # instruction
            rule = PARSE_TABLE[mnem]

            opcode = match(mnem, args, rule, l_num)
            opargs = strip_args(args, l_num)

            print(opcode + " // " + line, file=out_file)
            byte = byte + 1

            for oparg in opargs:
                print(oparg, file=out_file)
                byte = byte + 1


n_arg = len(sys.argv)

if n_arg < 3:
    print("Usage: assemble input_file output_file")
    exit()

in_file_name = sys.argv[1]
try:
    in_file = open(in_file_name, "rt")
except FileNotFoundError:
    print(f"Input file '{in_file_name}' does not exist")
    exit()

out_file_name = sys.argv[2]
out_file = open(out_file_name, "wt")

assemble(in_file, out_file)
