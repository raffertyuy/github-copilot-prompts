# Rock-Paper-Scissors-Lizard-Spock Game

A Node.js console application implementing the extended Rock-Paper-Scissors game made famous by "The Big Bang Theory".

## Game Rules

The game follows the classic Rock-Paper-Scissors-Lizard-Spock rules:

- **Rock** crushes **Lizard** and crushes **Scissors**
- **Paper** covers **Rock** and disproves **Spock**
- **Scissors** cuts **Paper** and decapitates **Lizard**
- **Lizard** poisons **Spock** and eats **Paper**
- **Spock** smashes **Scissors** and vaporizes **Rock**

## How to Play

1. Run the game:
   ```bash
   node rock-paper-scissors-lizard-spock.js
   ```

2. Enter your choice when prompted:
   - Full names: `rock`, `paper`, `scissors`, `lizard`, `spock`
   - Abbreviations: `r`, `p`, `s`, `l`, `sp`

3. The computer will randomly choose its move

4. The game is played best out of 5 rounds

5. Type `quit` at any time to exit the game

## Features

- ✅ Input validation with helpful error messages
- ✅ Support for abbreviations (r, p, s, l, sp)
- ✅ Case-insensitive input handling
- ✅ Real-time scoring system
- ✅ Descriptive action messages (e.g., "rock crushes scissors")
- ✅ Best out of 5 game format
- ✅ Graceful exit with quit command

## Example Game Output

```
Welcome to Rock-Paper-Scissors-Lizard-Spock!
==================================================
Rules:
• Rock crushes Lizard and crushes Scissors
• Paper covers Rock and disproves Spock
• Scissors cuts Paper and decapitates Lizard
• Lizard poisons Spock and eats Paper
• Spock smashes Scissors and vaporizes Rock

Best out of 5 games wins!
Enter your choice (rock, paper, scissors, lizard, spock)
You can also use abbreviations: r, p, s, l, sp
Type "quit" to exit the game.
==================================================

Game 1/5 - Enter your choice: rock

Round 1:
You chose: rock
Computer chose: scissors
You win! rock crushes scissors
Score: You 1 - 0 Computer

Game 2/5 - Enter your choice: paper

Round 2:
You chose: paper
Computer chose: lizard
Computer wins! lizard eats paper
Score: You 1 - 1 Computer
```

## Code Structure

The application is modular and exports key functions for testing:

- `getComputerChoice()`: Generates random computer choice
- `validateInput(input)`: Validates and normalizes user input
- `determineWinner(player, computer)`: Determines round winner
- `getActionDescription(winner, loser)`: Returns action description

## Requirements

- Node.js (tested with v20.19.2)
- No external dependencies required

## Testing

The game includes comprehensive input validation and error handling. All game logic functions are exported and can be tested independently.