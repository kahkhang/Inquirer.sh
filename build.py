#!/usr/bin/python
import re

commonFile = open("dev/inquirer_common.sh", "r")
common = commonFile.read()
commonFile.close()

files = ["checkbox_input.sh", "list_input.sh", "text_input.sh"]
main = common
for f in files:
    fileObject = open("dev/" + f, "r")
    text = fileObject.read()
    updated = re.sub('### IMPORT_COMMON ###([\s\S]*)### IMPORT_END ###', common, text, re.MULTILINE)
    main = main + re.sub('### IMPORT_COMMON ###([\s\S]*)### IMPORT_END ###', "", text, re.MULTILINE)
    newFile = open("dist/"+f, "w")
    newFile.write(updated)
    newFile.flush()
    newFile.close()

mainFile = open("dist/inquirer.sh", "w")
mainFile.write(main)
mainFile.flush()
mainFile.close()
