## Inquirer.sh

A collection of common interactive command line user interfaces, written in bash. Inspired by [Inquirer.js](https://github.com/SBoudrias/Inquirer.js)

### List Input Usage
![List Input Example](screenshots/list_input.png "List Input Example")

```sh
source list_input.sh

drinks=( 'Teh' 'Teh Ping Gao Siu Dai' 'Kopi O' 'Yuan Yang' )
list_input "What would you like to drink today?" "${drinks[@]}"

echo "Selected: ${drinks[$selected_index]}"
```
