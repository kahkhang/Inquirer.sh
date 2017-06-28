#!/usr/bin/python
import re

hashbang = "#!/bin/bash"

commonFile = open("dev/inquirer_common.sh", "r")
common = commonFile.read().replace(hashbang, "")
commonFile.close()

files = ["checkbox_input.sh", "list_input.sh", "text_input.sh"]
main = hashbang + "\n" + common
for f in files:
    fileObject = open("dev/" + f, "r")
    text = fileObject.read().replace(hashbang, "")
    updated = hashbang + "\n" + common + "\n" + re.sub('### IMPORT_COMMON ###([\s\S]*)### IMPORT_END ###', "", text, re.MULTILINE)
    main = main + re.sub('### IMPORT_COMMON ###([\s\S]*)### IMPORT_END ###', "", text, re.MULTILINE)
    newFile = open("dist/"+f, "w")
    newFile.write(updated)
    newFile.flush()
    newFile.close()

mainFile = open("dist/inquirer.sh", "w")
mainFile.write(main)
mainFile.flush()
mainFile.close()
