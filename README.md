# Terravolve

Terravolve is a visual evolution simulator developed using Processing. In this simulation, herbivores (green) and carnivores (red) live in a flat world where food (black dots) spawns sporadically. The creatures must feed or starve, and if they have enough extra health the herbivores will lay eggs and the carnivores will birth offspring. These children will have mutated features, either increasing or decreasing expression. Over time, only the healthiest creatures will survive, and competition between species will push for ever-stronger genes.

The user can select any creature to highlight them and view their specific features in the bottom left corner. Additionally, the user will be able to see that creature's viewing distance - creatures with great enough sight will be displayed with an eyeball on their body. Pressing the space key will display statistics on both of the populations overall. The speed of time can also be controlled with +/- keys.

## Features

The following features can be mutated for the two species:

- Mutation Rate (How much these features get mutated in children)
- Digestion (How well the creatures process food)
- Birthrate (How often the creature produces offspring, which reduces health)
- Waver (How sporadically the creatures move)
- Sight (How far the creatures can see, they will avoid predators and seek food)
- Speed
- Max Health
- Egg Time (Herbivores only, how long to wait before hatching)

## Code

The code for Terravolve consists of classes for carnivores, eggs, food, and herbivores, as well as helper functions for displaying the screen, updating the game state, and calculating the mutations.

## Usage

To run the simulation, you will need to have Processing installed. Once installed, simply open the `Terravolve.pde` file and run the sketch. 

## License

This project is licensed under the MIT License. See the `LICENSE` file for more information.
