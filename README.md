## Inquirer.sh

A collection of common interactive command line user interfaces, written in bash. Inspired by [Inquirer.js](https://github.com/SBoudrias/Inquirer.js)

### List Input
![List Input Example](screenshots/list_input.png "List Input Example")

```sh
source list_input.sh

drinks=( 'Teh' 'Teh Ping Gao Siu Dai' 'Kopi O' 'Yuan Yang' )
list_input "What would you like to drink today?" drinks

print "Selected: ${drinks[$selected_index]}"
```

### Checkbox Input
![Checkbox Input Example](screenshots/checkbox_input.png "Checkbox Input Example")

```sh
source checkbox_input.sh

hawker_centres=( 'Old Airport Road Hawker Centre' 'Golden Mile Food Complex' 'Maxwell Food Centre' 'Newton Food Centre' )
checkbox_input "Which hawker centres do you prefer?" hawker_centres
selected_hawkers=( "${selected_options[@]}" )
print "Selected indices $(join "${selected_indices[@]}")"
print "Hawker Centres: $(join "${selected_hawkers[@]}")"
```
