from dataclasses import dataclass
from enum import Enum, auto


@dataclass(frozen=True)
class Card:
    name: str
    cost: int
    types: set[CardType]

    treasure: int = 0
    victory_points: int = 0

class CardType(Enum):
    ACTION = auto()
    TREASURE = auto()
    VICTORY = auto()
    ATTACK = auto()
    REACTION = auto()
