from dataclasses import dataclass, field
from enum import Enum, auto

from dominion.cardsets.base import COPPER, DUCHY, ESTATE, GOLD, MOAT, PROVINCE, SILVER, SMITHY, VILLAGE
from dominion.player import Player
from dominion.supply import SupplyPile

class Phase(Enum):
    ACTION = auto()
    TREASURE = auto()
    BUY = auto()
    CLEANUP = auto()

@dataclass
class GameState:
    players: list[Player]
    current_player: int = 0
    turn: int = 1
    phase: Phase = Phase.ACTION

    supply: list[SupplyPile] = field(default_factory=lambda: [
        SupplyPile(COPPER, 60),
        SupplyPile(SILVER, 40),
        SupplyPile(GOLD, 30),
        SupplyPile(ESTATE, 8),
        SupplyPile(DUCHY, 8),
        SupplyPile(PROVINCE, 8),
        SupplyPile(VILLAGE),
        SupplyPile(SMITHY),
        SupplyPile(MOAT)
    ])

    def active_player(self) -> Player:
        return self.players[self.current_player]
