#!/usr/bin/ruby

# Gregorian & Jalali ( Hijri_Shamsi , Solar ) Date Converter  Functions
# Author: JDF.SCR.IR =>> Download Full Version :  http://jdf.scr.ir/jdf
# License: GNU/LGPL _ Open Source & Free :: Version: 2.80 : [2020=1399]
# ---------------------------------------------------------------------
# 355746=361590-5844 & 361590=(30*33*365)+(30*8) & 5844=(16*365)+(16/4)
# 355666=355746-79-1 & 355668=355746-79+1 &  1595=605+990 &  605=621-16
# 990=30*33 & 12053=(365*33)+(32/4) & 36524=(365*100)+(100/4)-(100/100)
# 1461=(365*4)+(4/4)   &   146097=(365*400)+(400/4)-(400/100)+(400/400)


# @param [Integer] gy
# @param [Integer] gm
# @param [Integer] gd
# @return [Array Integer] [jy,jm,jd]
def gregorian_to_jalali(gy, gm, gd)
 g_d_m = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334]
 (gm > 2) ? gy2 = gy + 1 : gy2 = gy
 days = 355666 + (365 * gy) + Integer((gy2 + 3) / 4) - Integer((gy2 + 99) / 100) + Integer((gy2 + 399) / 400) + gd + g_d_m[gm - 1]
 jy = -1595 + (33 * Integer(days / 12053))
 days %= 12053
 jy += 4 * Integer(days / 1461)
 days %= 1461
 if days > 365
   jy += Integer((days - 1) / 365)
   days = (days - 1) % 365
 end
 if days < 186
   jm = 1 + Integer(days / 31)
   jd = 1 + (days % 31)
 else
   jm = 7 + Integer((days - 186) / 30)
   jd = 1 + ((days - 186) % 30)
 end
 [jy, jm, jd]
end


# @param [Integer] jy
# @param [Integer] jm
# @param [Integer] jd
# @return [Array Integer] [gy,gm,gd]
def jalali_to_gregorian(jy, jm, jd)
 jy += 1595
 days = -355668 + (365 * jy) + (Integer(jy / 33) * 8) + Integer(((jy % 33) + 3) / 4) + jd + ((jm < 7) ? (jm - 1) * 31 : ((jm - 7) * 30) + 186)
 gy = 400 * Integer(days / 146097)
 days %= 146097
 if days > 36524
   days -= 1
   gy += 100 * Integer(days / 36524)
   days %= 36524
   days += 1 if days >= 365
 end
 gy += 4 * Integer(days / 1461)
 days %= 1461
 if days > 365
   gy += Integer((days - 1) / 365)
   days = (days - 1) % 365
 end
 gd = days + 1
 sal_a = [0, 31, ((gy % 4 == 0 and gy % 100 != 0) or (gy % 400 == 0)) ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
 gm = 0
 while gm < 13 and gd > sal_a[gm]
   gd -= sal_a[gm]
   gm += 1
 end
 [gy, gm, gd]
end




# Example 1:

while 1
 print "----------------------------------\n\nif gregorian_to_jalali -> press: g\nor jalali_to_gregorian -> press: j\nand finish -> 	press: Ctrl+C\n"
 tabdil = gets.chomp
 puts 'enter day: '
 day_in=Integer(gets)
 puts 'enter month: '
 month_in=Integer(gets)
 puts 'enter year: '
 year_in=Integer(gets)
 print tabdil
 if tabdil.eql? 'g'
   print "----------------------------------\n Gregorian: \t#{year_in}/#{month_in}/#{day_in}\n"
   tarikh_out=gregorian_to_jalali(year_in, month_in, day_in)
   print " Jalali: \t#{tarikh_out[0]}/#{tarikh_out[1]}/#{tarikh_out[2]}\n"
 else
   print "----------------------------------\n Jalali: \t#{year_in}/#{month_in}/#{day_in}\n"
   tarikh_out=jalali_to_gregorian(year_in, month_in, day_in)
   print " Gregorian: \t#{tarikh_out[0]}/#{tarikh_out[1]}/#{tarikh_out[2]}\n"
 end
end



# # Example 2:

# tarikh_out=gregorian_to_jalali(2020,5,17)
# print " jalali: \t#{tarikh_out[0]}/#{tarikh_out[1]}/#{tarikh_out[2]}\n"

# tarikh_out=jalali_to_gregorian(1399,2,28)
# print " gregorian: \t#{tarikh_out[0]}-#{tarikh_out[1]}-#{tarikh_out[2]}\n"


