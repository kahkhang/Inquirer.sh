## Inquirer.sh

A collection of common interactive command line user interfaces, written in bash. Inspired by [Inquirer.js](https://github.com/SBoudrias/Inquirer.js)

### List Input
![List Input Example](screenshots/list_input.png "List Input Example")

```sh
source list_input.sh

drinks=( 'Teh' 'Teh Ping Gao Siu Dai' 'Kopi O' 'Yuan Yang' )
list_input "What would you like to drink today (1st Drink)?" drinks selected_drink
echo "Selected: $selected_drink"

drinks=( 'Teh' 'Teh Ping Gao Siu Dai' 'Kopi O' 'Yuan Yang' )
list_input_index "What would you like to drink today (2nd Drink)?" drinks selected_drink_index
echo "Selected Index: $selected_drink_index"
```

### Checkbox Input
![Checkbox Input Example](screenshots/checkbox_input.png "Checkbox Input Example")

```sh
source checkbox_input.sh

hawker_centres=( 'Old Airport Road Hawker Centre' 'Golden Mile Food Complex' 'Maxwell Food Centre' 'Newton Food Centre' )
checkbox_input "Which hawker centres do you prefer?" hawker_centres selected_hawkers
echo "Hawker Centres: $(join "${selected_hawkers[@]}")"

hawker_centres=( 'Old Airport Road Hawker Centre' 'Golden Mile Food Complex' 'Maxwell Food Centre' 'Newton Food Centre' )
checkbox_input_indices "Which hawker centres do you prefer?" hawker_centres selected_hawkers_indices
echo "Hawker Centre Indices: $(join "${selected_hawkers_indices[@]}")"
```

### Text Input
![Text Input Example](screenshots/text_input.png "Text Input Example")

```sh
source text_input.sh

text_input "What's your first name" name
echo "Hello $name"
```

### [License](https://github.com/tanhauhau/Inquirer.sh/blob/master/LICENSE)

### [Contributors](https://github.com/tanhauhau/Inquirer.sh/blob/master/CONTRIBUTORS.md)
