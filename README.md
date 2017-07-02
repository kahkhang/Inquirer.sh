## :rocket: Inquirer.sh - Modern Terminal Prompt in Bash
[![Bash](https://img.shields.io/badge/language-Bash-green.svg)](https://github.com/tanhauhau/Inquirer.sh) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/tanhauhau/Inquirer.sh/master/LICENSE) [![Twitter](https://img.shields.io/twitter/url/https/github.com/tanhauhau/Inquirer.sh.svg?style=social)](https://twitter.com/intent/tweet?text=%23Inquirer.sh%20rocks%21&url=%5Bobject%20Object%5D)

A collection of common interactive command line user interfaces, written in bash. Inspired by [Inquirer.js](https://github.com/SBoudrias/Inquirer.js)

### List Input
![List Input Example](demos/list_input.gif "List Input Example")

```sh
source dist/list_input.sh

drinks=( 'Teh' 'Teh Ping Gao Siu Dai' 'Kopi O' 'Yuan Yang' )
list_input "What would you like to drink today (1st Drink)?" drinks selected_drink

food=( 'Chicken Rice' 'Lor Mee' 'Nasi Lemak' 'Bak Kut Teh' )
list_input "What would you like to eat today?" food selected_food

echo "Drink: $selected_drink"
echo "Food: $selected_food"
```

### Checkbox Input
![Checkbox Input Example](demos/checkbox_input.gif "Checkbox Input Example")

```sh
source dist/checkbox_input.sh

hawker_centres=( 'Old Airport Road Hawker Centre' 'Golden Mile Food Complex' 'Maxwell Food Centre' 'Newton Food Centre' )
checkbox_input "Which hawker centres do you prefer?" hawker_centres selected_hawkers

drinks=( 'Teh' 'Teh Ping Gao Siu Dai' 'Kopi O' 'Yuan Yang' )
checkbox_input "Which drinks do you prefer?" drinks selected_drinks
echo "Preferred Hawker Centres: $(join selected_hawkers)"
echo "Preferred Drinks: $(join drinks)"

```

### Text Input
![Text Input Example](demos/text_input.gif "Text Input Example")

```sh
source dist/text_input.sh

text_input "What's your first name" name
echo "Hello $name"
```

### [Contributors](https://github.com/tanhauhau/Inquirer.sh/blob/master/CONTRIBUTORS.md)
