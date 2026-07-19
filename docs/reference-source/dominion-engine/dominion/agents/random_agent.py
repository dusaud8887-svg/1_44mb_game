import random

from dominion.moves import Move
from dominion.state import GameState


class RandomAgent:
    def choose(self, state: GameState, moves: list[Move]) -> Move:  # pyright: ignore[reportUnusedParameter]
        return random.choice(moves)
