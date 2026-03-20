#!/usr/bin/env node

/**
 * Rock-Paper-Scissors-Lizard-Spock Game
 * 
 * A console application implementing the extended Rock-Paper-Scissors game.
 * Rules:
 * - Rock crushes Lizard and crushes Scissors
 * - Paper covers Rock and disproves Spock
 * - Scissors cuts Paper and decapitates Lizard
 * - Lizard poisons Spock and eats Paper
 * - Spock smashes Scissors and vaporizes Rock
 * 
 * Best out of 5 games wins.
 */

const readline = require('readline');

// Game constants
const CHOICES = ['rock', 'paper', 'scissors', 'lizard', 'spock'];
const WINNING_COMBINATIONS = {
    rock: ['lizard', 'scissors'],
    paper: ['rock', 'spock'],
    scissors: ['paper', 'lizard'],
    lizard: ['spock', 'paper'],
    spock: ['scissors', 'rock']
};

const ACTIONS = {
    rock: { lizard: 'crushes', scissors: 'crushes' },
    paper: { rock: 'covers', spock: 'disproves' },
    scissors: { paper: 'cuts', lizard: 'decapitates' },
    lizard: { spock: 'poisons', paper: 'eats' },
    spock: { scissors: 'smashes', rock: 'vaporizes' }
};

// Game state
let playerScore = 0;
let computerScore = 0;
let gameNumber = 1;
const MAX_GAMES = 5;

// Create readline interface
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

/**
 * Generate random computer choice
 * @returns {string} Computer's choice
 */
function getComputerChoice() {
    const randomIndex = Math.floor(Math.random() * CHOICES.length);
    return CHOICES[randomIndex];
}

/**
 * Validate player input
 * @param {string} input - Player's input
 * @returns {string|null} Normalized choice or null if invalid
 */
function validateInput(input) {
    const normalizedInput = input.toLowerCase().trim();
    
    // Check exact match
    if (CHOICES.includes(normalizedInput)) {
        return normalizedInput;
    }
    
    // Check for common abbreviations
    const abbreviations = {
        'r': 'rock',
        'p': 'paper',
        's': 'scissors',
        'l': 'lizard',
        'sp': 'spock'
    };
    
    if (abbreviations[normalizedInput]) {
        return abbreviations[normalizedInput];
    }
    
    return null;
}

/**
 * Determine winner of a single round
 * @param {string} playerChoice - Player's choice
 * @param {string} computerChoice - Computer's choice
 * @returns {string} Result: 'player', 'computer', or 'tie'
 */
function determineWinner(playerChoice, computerChoice) {
    if (playerChoice === computerChoice) {
        return 'tie';
    }
    
    if (WINNING_COMBINATIONS[playerChoice].includes(computerChoice)) {
        return 'player';
    }
    
    return 'computer';
}

/**
 * Get action description for the winning combination
 * @param {string} winner - Winner's choice
 * @param {string} loser - Loser's choice
 * @returns {string} Action description
 */
function getActionDescription(winner, loser) {
    return ACTIONS[winner][loser];
}

/**
 * Display game results
 * @param {string} playerChoice - Player's choice
 * @param {string} computerChoice - Computer's choice
 * @param {string} result - Round result
 */
function displayRoundResult(playerChoice, computerChoice, result) {
    console.log(`\nRound ${gameNumber}:`);
    console.log(`You chose: ${playerChoice}`);
    console.log(`Computer chose: ${computerChoice}`);
    
    if (result === 'tie') {
        console.log("It's a tie!");
    } else if (result === 'player') {
        const action = getActionDescription(playerChoice, computerChoice);
        console.log(`You win! ${playerChoice} ${action} ${computerChoice}`);
        playerScore++;
    } else {
        const action = getActionDescription(computerChoice, playerChoice);
        console.log(`Computer wins! ${computerChoice} ${action} ${playerChoice}`);
        computerScore++;
    }
    
    console.log(`Score: You ${playerScore} - ${computerScore} Computer`);
}

/**
 * Display final game results
 */
function displayFinalResult() {
    console.log('\n' + '='.repeat(50));
    console.log('FINAL RESULTS');
    console.log('='.repeat(50));
    console.log(`Final Score: You ${playerScore} - ${computerScore} Computer`);
    
    if (playerScore > computerScore) {
        console.log('🎉 Congratulations! You won the game!');
    } else if (computerScore > playerScore) {
        console.log('💻 Computer wins! Better luck next time!');
    } else {
        console.log('🤝 It\'s a tie game!');
    }
    
    console.log('Thanks for playing Rock-Paper-Scissors-Lizard-Spock!');
}

/**
 * Display game instructions
 */
function displayInstructions() {
    console.log('Welcome to Rock-Paper-Scissors-Lizard-Spock!');
    console.log('='.repeat(50));
    console.log('Rules:');
    console.log('• Rock crushes Lizard and crushes Scissors');
    console.log('• Paper covers Rock and disproves Spock');
    console.log('• Scissors cuts Paper and decapitates Lizard');
    console.log('• Lizard poisons Spock and eats Paper');
    console.log('• Spock smashes Scissors and vaporizes Rock');
    console.log('');
    console.log('Best out of 5 games wins!');
    console.log('Enter your choice (rock, paper, scissors, lizard, spock)');
    console.log('You can also use abbreviations: r, p, s, l, sp');
    console.log('Type "quit" to exit the game.');
    console.log('='.repeat(50));
}

/**
 * Play a single round
 */
function playRound() {
    if (gameNumber > MAX_GAMES) {
        displayFinalResult();
        rl.close();
        return;
    }
    
    const prompt = `\nGame ${gameNumber}/${MAX_GAMES} - Enter your choice: `;
    
    rl.question(prompt, (input) => {
        if (input.toLowerCase().trim() === 'quit') {
            console.log('Thanks for playing!');
            rl.close();
            return;
        }
        
        const playerChoice = validateInput(input);
        
        if (!playerChoice) {
            console.log('Invalid choice! Please enter: rock, paper, scissors, lizard, or spock');
            console.log('Or use abbreviations: r, p, s, l, sp');
            playRound();
            return;
        }
        
        const computerChoice = getComputerChoice();
        const result = determineWinner(playerChoice, computerChoice);
        
        displayRoundResult(playerChoice, computerChoice, result);
        
        gameNumber++;
        
        // Check if game should continue
        if (gameNumber <= MAX_GAMES) {
            playRound();
        } else {
            displayFinalResult();
            rl.close();
        }
    });
}

/**
 * Start the game
 */
function startGame() {
    displayInstructions();
    playRound();
}

// Handle process termination
rl.on('close', () => {
    console.log('\nGoodbye!');
    process.exit(0);
});

// Start the game
if (require.main === module) {
    startGame();
}

module.exports = {
    getComputerChoice,
    validateInput,
    determineWinner,
    getActionDescription,
    CHOICES,
    WINNING_COMBINATIONS,
    ACTIONS
};