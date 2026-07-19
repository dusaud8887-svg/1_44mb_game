from dominion.cards import Card
from dominion.cardsets.base import GOLD, PROVINCE, SILVER
from dominion.moves import BuyCard, EndActionPhase, EndBuyPhase, Move
from dominion.state import GameState, Phase


class BigMoney:
    def choose(self, state: GameState, moves: list[Move]) -> Move:
        phase = state.phase

        if phase == Phase.ACTION:
            for move in moves:
                if isinstance(move, EndActionPhase):
                    return move

        if phase == Phase.BUY:
            buy_moves = [
                move
                for move in moves
                if isinstance(move, BuyCard)
            ]

            def pick(card: Card) -> Move | None:
                for m in buy_moves:
                    if m.card is card:
                        return m

            return (
                pick(PROVINCE)
                or pick(GOLD)
                or pick(SILVER)
                or next((m for m in moves if isinstance(m, EndBuyPhase)), moves[0])
            )

        # Should never get here
        return moves[0]
