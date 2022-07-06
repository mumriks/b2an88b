# -*- coding: utf-8 -*-
# N88-BASIC(PC-8800) 中間コードファイルをアスキーに変換
# @kishi24 2022/06/10 ver.1.6.1

#require 'optparse'
Version = "1.6.1"

@offset = 0

@s_data = {"80" => "",
    "81" => "END",
    "82" => "FOR",
    "83" => "NEXT",
    "84" => "DATA",
    "85" => "INPUT",
    "86" => "DIM",
    "87" => "READ",
    "88" => "LET",
    "89" => "GOTO",
    "8A" => "RUN",
    "8B" => "IF",
    "8C" => "RESTORE",
    "8D" => "GOSUB",
    "8E" => "RETURN",
    "8F" => "REM",
    "90" => "STOP",
    "91" => "PRINT",
    "92" => "CLEAR",
    "93" => "LIST",
    "94" => "NEW",
    "95" => "ON",
    "96" => "WAIT",
    "97" => "DEF",
    "98" => "POKE",
    "99" => "CONT",
    "9A" => "OUT",
    "9B" => "LPRINT",
    "9C" => "LLIST",
    "9D" => "CONSOLE",
    "9E" => "WIDTH",
    "9F" => "ELSE",
    "A0" => "TRON",
    "A1" => "TROFF",
    "A2" => "SWAP",
    "A3" => "ERASE",
    "A4" => "EDIT",
    "A5" => "ERROR",
    "A6" => "RESUME",
    "A7" => "DELETE",
    "A8" => "AUTO",
    "A9" => "RENUM",
    "AA" => "DEFSTR",
    "AB" => "DEFINT",
    "AC" => "DEFSNG",
    "AD" => "DEFDBL",
    "AE" => "LINE",
    "AF" => "WHILE",
    "B0" => "WEND",
    "B1" => "CALL",
    "B2" => "",
    "B3" => "",
    "B4" => "",
    "B5" => "WRITE",
    "B6" => "COMMON",
    "B7" => "CHAIN",
    "B8" => "OPTION",
    "B9" => "RANDOMIZE",
    "BA" => "DSKO$",
    "BB" => "OPEN",
    "BC" => "FIELD",
    "BD" => "GET",
    "BE" => "PUT",
    "BF" => "SET",
    "C0" => "CLOSE",
    "C1" => "LOAD",
    "C2" => "MERGE",
    "C3" => "FILES",
    "C4" => "NAME",
    "C5" => "KILL",
    "C6" => "LSET",
    "C7" => "RSET",
    "C8" => "SAVE",
    "C9" => "LFILES",
    "CA" => "MON",
    "CB" => "COLOR",
    "CC" => "CIRCLE",
    "CD" => "COPY",
    "CE" => "CLS",
    "CF" => "PSET",
    "D0" => "PRESET",
    "D1" => "PAINT",
    "D2" => "TERM",
    "D3" => "SCREEN",
    "D4" => "BLOAD",
    "D5" => "BSAVE",
    "D6" => "LOCATE",
    "D7" => "BEEP",
    "D8" => "ROLL",
    "D9" => "HELP",
    "DA" => "",
    "DB" => "KANJI",
    "DC" => "TO",
    "DD" => "THEN",
    "DE" => "TAB(",
    "DF" => "STEP",
    "E0" => "USR",
    "E1" => "FN",
    "E2" => "SPC(",
    "E3" => "NOT",
    "E4" => "ERL",
    "E5" => "ERR",
    "E6" => "STRING$",
    "E7" => "USING",
    "E8" => "INSTR",
    "E9" => "'",
    "EA" => "VARPTR",
    "EB" => "ATTR$",
    "EC" => "DSKI$",
    "ED" => "SRQ",
    "EE" => "OFF",
    "EF" => "INKEY$",
    "F0" => ">",
    "F1" => "=",
    "F2" => "<",
    "F3" => "+",
    "F4" => "-",
    "F5" => "*",
    "F6" => "/",
    "F7" => "^",
    "F8" => "AND",
    "F9" => "OR",
    "FA" => "XOR",
    "FB" => "EQV",
    "FC" => "IMP",
    "FD" => "MOD",
    "FE" => "\\"}

@w_data = {"80" => "",
    "81" => "LEFT$",
    "82" => "RIGHT$",
    "83" => "MID$",
    "84" => "SGN",
    "85" => "INT",
    "86" => "ABS",
    "87" => "SQR",
    "88" => "RND",
    "89" => "SIN",
    "8A" => "LOG",
    "8B" => "EXP",
    "8C" => "COS",
    "8D" => "TAN",
    "8E" => "ATN",
    "8F" => "FRE",
    "90" => "INP",
    "91" => "POS",
    "92" => "LEN",
    "93" => "STR$",
    "94" => "VAL",
    "95" => "ASC",
    "96" => "CHR$",
    "97" => "PEEK",
    "98" => "SPACE$",
    "99" => "OCT$",
    "9A" => "HEX$",
    "9B" => "LPOS",
    "9C" => "CINT",
    "9D" => "CSNG",
    "9E" => "CDBL",
    "9F" => "FIX",
    "A0" => "CVI",
    "A1" => "CVS",
    "A2" => "CVD",
    "A3" => "EOF",
    "A4" => "LOC",
    "A5" => "LOF",
    "A6" => "FPOS",
    "A7" => "MKI$",
    "A8" => "MKS$",
    "A9" => "MKD$",
    "AA" => "",
    "CF" => "",
    "D0" => "DSKF",
    "D1" => "VIEW",
    "D2" => "WINDOW",
    "D3" => "POINT",
    "D4" => "CSRLIN",
    "D5" => "MAP",
    "D6" => "SEARCH",
    "D7" => "MOTOR",
    "D8" => "PEN",
    "D9" => "DATE$",
    "DA" => "COM",
    "DB" => "KEY",
    "DC" => "TIME$",
    "DD" => "WBYTE",
    "DE" => "RBYTE",
    "DF" => "POLL",
    "E0" => "ISET",
    "E1" => "IEEE",
    "E2" => "IRESET",
    "E3" => "STATUS",
    "E4" => "CMD",
    "E5" => ""}



def tohex(data)
    return data.unpack("H*").first.upcase
end
def read_w(file)
    data = file.read(1)
    mae = tohex(data)
    data = file.read(1)
    ato = tohex(data)
    return ato + mae
end
def read_s(file)
    data = file.read(1)
    return tohex(data)
end
def read_4byte(file)
    one = read_s(file)
    two = read_s(file)
    three = read_s(file)
    data = file.read(1)
    e = tohex(data)

    return "0" if 0 == e.hex

# 仮数部の処理
    kasu = three + two + one
    frac = kasu.hex.to_s(2)

    # to_s(2) による桁落ちを補正
    if 24 > frac.size
        (24 - frac.size).times {|i| frac = "0" + frac}
    end
    e = e.hex - 129
    sign = ""
    if "1" == frac[0, 1]
        sign = "-"
    else
        frac[0, 1] = "1"
    end
# 0b から実数へ変換
    num = 0.0
    (0..22).each {|i|
        if "1" == frac[i, 1]
            num += 1 / 2.0 ** i
        end
    }
    num = num * (2 ** e)

# 有効桁 7 におさめて行末の 0 を削除
    data = num.to_s.split(/\./)
    if /^0+$/ =~ data[1]
        return "-#{data[0]}!" if "-" == sign
        return "#{data[0]}!"
    end
    if "0" == data[0]
        nth = 7 - data[0].size
    else
        nth = 6 - data[0].size
    end
    num = num.round(nth)
    num = num.to_s.sub(/0+$/,"")
    num = num.to_s.sub(/\.$/,"")
    num = num.to_s.sub(/^0\./, "\.")
    num = "-#{num}" if "-" == sign
    return num
end
def read_8byte(file)
    one = read_s(file)
    two = read_s(file)
    three = read_s(file)
    four = read_s(file)
    five = read_s(file)
    six = read_s(file)
    seven = read_s(file)
    data = file.read(1)
    e = tohex(data)
    return "0" if 0 == e.hex
    kasu = seven + six + five + four + three + two + one
    frac = kasu.hex.to_s(2)
    if 56 > frac.size
        (56 - frac.size).times {|i| frac = "0" + frac}
    end
    e = e.hex - 129
    sign = ""
    if "1" == frac[0, 1]
        sign = "-"
    else
        frac[0, 1] = "1"
    end
    num = 0.0
    (0..55).each {|i|
        if "1" == frac[i, 1]
            num += 1 / 2.0 ** i
        end
    }
    num = num * (2 ** e)
    if "0" == data[0]
        nth = 17 - data[0].size
    else
        nth = 16 - data[0].size
    end
    num = num.round(nth)

    num = num.to_s.sub(/0+$/,"")
    num = num.to_s.sub(/\.$/,"")
    num = num.to_s.sub(/^0\./, "\.")
    num = "-#{num}" if "-" == sign
    return num
end

def main(file)
    point =[1]
    num = 1
    text = 0
    ifthen = 0

    File.open(file) {|f|
        File.open("#{File.dirname(file)}/#{File.basename(file)}.asc", "w") {|wf|
        while pt = read_w(f)
            break if "0000" == pt

            point.push(pt.hex - @offset - 2 * num)

            num += 1
            p_num = point[1] - point[0]
            line_num = read_w(f)
            wf.print "#{line_num.hex} "
            p_num -= 2
            remark = ""

            while p_num > 0
                dump = read_s(f)
                p_num -= 1
                if "0A" == dump
                    # LF
                    data = ["0A"].pack("H*")
                    wf.print data
                elsif "0B" == dump
                    # 2 byte Octet
                    fig = read_w(f)
                    wf.print "&O#{fig.hex.to_s(8)}"
                    p_num -= 2
                elsif "0C" == dump
                    # 2 byte Hexa
                    fig = read_w(f)
                    wf.print "&H#{fig}"
                    p_num -= 2
                elsif "0D" == dump
                    # 2 byte address
                    fig = read_w(f)
                    wf.print "#{fig}H"
                    p_num -= 2
                elsif "0E" == dump
                    # 2 byte integer
                    fig = read_w(f)
                    wf.print "#{fig.hex}"
                    p_num -= 2
                elsif "0F" == dump
                    # 1 byte integer
                    fig = read_s(f)
                    wf.print "#{fig.hex}"
                    p_num -= 1
                elsif 16 < dump.hex && 27 > dump.hex
                    # 1 byte integer
                    wf.print "#{dump.hex - 17}"
                elsif "1B" == dump
                    wf.print "10"
                elsif "1C" == dump
                    fig = read_w(f)
                    wf.print "#{fig.hex}"
                    p_num -= 2
                elsif "1D" == dump
                    fig = read_4byte(f)
                    wf.print "#{fig}"
                    p_num -= 4
                elsif "1F" == dump
                    fig  = read_8byte(f)
                    wf.print "#{fig}#"
                    p_num -= 8
                elsif 31 < dump.hex && 128 > dump.hex
                    if "3A" != dump
                        if "3A" == remark
                            wf.print "#{remark.hex.chr}"
                            remark = ""
                        end
                        wf.print "#{dump.hex.chr}"
                        if "22" == dump
                            if 0 == text
                                text = 1
                            else
                                text = 0
                            end
                        end
                        text = 1 if "27" == dump   # '
                    elsif 1 == ifthen && "3A" == dump
                        ifthen = 2
                        if "" == remark
                            remark += dump
                        else
                            wf.print "#{remark.hex.chr}"
                            remark = ""
                        end
                    else
                        if "" == remark
                            remark += dump
                        else
                            wf.print "#{remark.hex.chr}"
                        end
                    end
                elsif 127 < dump.hex && 255 > dump.hex
                    if 0 == text
                        if "3A" == remark && "8F" == dump # REM
                            remark += dump

                        elsif "3A8F" == remark && "E9" == dump # :REM'
                            wf.print "#{@s_data[dump]}"
                            remark = ""
                            text = 1

                        elsif "8B" == dump # if
                            ifthen = 1 
                            wf.print "#{@s_data[dump]}"

                        elsif "3A" == remark && "9F" == dump
                            remark = ""
                            wf.print "#{@s_data[dump]}"

                        else
                            if "3A" == remark
                                wf.print "#{remark.hex.chr}"
                                remark = ""
                            end
                            wf.print "#{@s_data[dump]}"
                            text = 1 if "8F" == dump # REM
                            text = 1 if "84" == dump # DATA
                        end
                    else

                        if "3A" == remark && "8F" == dump # REM
                            remark += dump
                        elsif "3A8F" == remark && "E9" == dump # :REM'
                            wf.print "#{@s_data[dump]}"
                            remark = ""
                            text = 1
                        else

                            wf.print "#{dump.hex.chr}"

                        end

                    end
                elsif "FF" == dump
                    fig = read_s(f)
                    wf.print "#{@w_data[fig]}"
                    p_num -= 1
                elsif "00" == dump
                    wf.print "#{remark.hex.chr}" if "" != remark
                    remark = ""
                    data = ["0D0A"].pack("H*")
                    wf.print data
                end
            end
            text = 0
            ifthen = 0
            point.shift
        end
        }
    }
end


path = ARGV.shift
bas_files = []

if path.nil?
    bas_files = Dir.glob(File.expand_path("#{Dir.pwd}/*.{BAS,bas}"))
elsif File.directory?(File.expand_path(path))
    bas_files = Dir.glob(File.expand_path("#{path}/*.{BAS,bas}"))
elsif File.exist?(path)
    bas_files << File.expand_path(path)
end


bas_files.each do |file|
    begin
        File.open(file) {|f|
            f.read(1)
            data = f.read(1)
            os = tohex(data)
            if "00" != os
                @offset = "#{os}00".hex 
                puts "offset: #{@offset.to_s(16).upcase}  #{file}\n\n"
            else
                puts "#{file}"
            end
        }
        main(file)
    rescue
        puts "ERROR: #{file}"
        if File.exist?("#{file}.asc")
            File.delete("#{file}.asc")
        end
    end
    @offset = 0
end
