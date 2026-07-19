from typing import Protocol

from dominion.moves import Move
from dominion.state import GameState


class Agent(Protocol):
    def choose(self, state: GameState, moves: list[Move]) -> Move:
        ...
