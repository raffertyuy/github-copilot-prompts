#!/usr/bin/env python3
"""
Rock-Paper-Scissors Game

A simple console application that allows you to play Rock-Paper-Scissors against the computer.
The game is played best out of 3, meaning the first to reach 3 points wins.
"""

import random

def get_user_choice():
    """
    Get the user's choice (rock, paper, or scissors).
    Validates input to ensure it's one of the valid options.

    Returns:
        str: The user's choice (rock, paper, or scissors)
    """
    valid_choices = ["rock", "paper", "scissors"]

    while True:
        user_choice = input("Enter your choice (rock, paper, or scissors): ").lower().strip()
        if user_choice in valid_choices:
            return user_choice
        print(f"Invalid choice. Please enter one of: {', '.join(valid_choices)}")

def get_computer_choice():
    """
    Generate a random choice for the computer.

    Returns:
        str: The computer's choice (rock, paper, or scissors)
    """
    return random.choice(["rock", "paper", "scissors"])

def determine_winner(user_choice, computer_choice):
    """
    Determine the winner of a round based on the choices.

    Args:
        user_choice (str): The user's choice
        computer_choice (str): The computer's choice

    Returns:
        str: 'user', 'computer', or 'tie'
    """
    if user_choice == computer_choice:
        return "tie"

    winning_combinations = {
        "rock": "scissors",
        "paper": "rock",
        "scissors": "paper"
    }

    if winning_combinations[user_choice] == computer_choice:
        return "user"
    return "computer"

def play_game():
    """
    Main game loop that plays Rock-Paper-Scissors until someone reaches 3 points.
    """
    user_score = 0
    computer_score = 0

    print("\n===== ROCK-PAPER-SCISSORS GAME =====")
    print("First to 3 points wins!\n")

    while user_score < 3 and computer_score < 3:
        print(f"\nScore: You {user_score} - {computer_score} Computer")

        user_choice = get_user_choice()
        computer_choice = get_computer_choice()

        print(f"You chose: {user_choice}")
        print(f"Computer chose: {computer_choice}")

        result = determine_winner(user_choice, computer_choice)

        if result == "user":
            user_score += 1
            print("You win this round!")
        elif result == "computer":
            computer_score += 1
            print("Computer wins this round!")
        else:
            print("It's a tie!")

    print("\n===== GAME OVER =====")
    if user_score > computer_score:
        print(f"You win the game! Final score: You {user_score} - {computer_score} Computer")
    else:
        print(f"Computer wins the game! Final score: You {user_score} - {computer_score} Computer")

if __name__ == "__main__":
    try:
        play_game()
    except KeyboardInterrupt:
        print("\nGame interrupted. Goodbye!")
