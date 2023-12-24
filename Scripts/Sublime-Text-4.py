# -*- coding: utf-8 -*-

#
# Cracker
#

st4_exe = 'sublime_text.exe'
with open(st4_exe, 'rb') as file_in:
    find = b'\x80\x78\x05\x00\x0f\x94\xc1'
    replace = b'\xc6\x40\x05\x01\x48\x85\xc9'

    content = bytearray(file_in.read())
    index = content.find(find)

    if index != -1:
        content[index:index+len(find)] = replace
        with open(st4_exe, 'wb') as file_out:
            file_out.write(content)
        print('Replacement succeeded.')
    else:
        print('No content was found to replace.')
