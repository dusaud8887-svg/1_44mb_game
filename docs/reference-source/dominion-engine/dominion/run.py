from collections.abc import Sequence
from dataclasses import dataclass

from dominion.agent import Agent
from dominion.agents.big_money import BigMoney
from dominion.agents.bm_smithy import BMSmithy
from dominion.agents.random_agent import RandomAgent
from dominion.game import Game
from dominion.moves import Move
from dominion.state import GameState


class Environment:
    game: Game

    def __init__(self):
        self.game = Game()

    def reset(self) -> GameState:
        self.game = Game()
        return self.game.state

    def step(self, move: Move):
        self.game.apply_move(move)

        return (
            self.game.state,
            self.game.is_game_over()
        )

    def legal_moves(self) -> list[Move]:
        return self.game.legal_moves()

    def run_game(self, agents: Sequence[Agent]) -> GameResult:
        state = self.game.state
        while True:
            player = self.game.active_player

            print(f"\n=== Turn {state.turn}: {player.name} ===")
            print("Hand:", ", ".join(card.name for card in player.hand))
            agent = agents[state.current_player]

            move = agent.choose(
                state,
                self.legal_moves()
            )

            print(f"{player.name} chooses {move}")
            state, done = self.step(move)

            if done:
                break

        print("\n====================\nGame Over\n")
        for player in state.players:
            print(
                player.name,
                player.score(),
                "VP"
            )

        winner = max(state.players, key=lambda player: player.score())
        print(f"Winner: {winner.name}")

        result = GameResult(state.players.index(winner), state.turn, [player.score() for player in state.players])
        _ = self.reset()
        return result


@dataclass
class GameResult:
    winner: int
    turns: int
    scores: list[int]

def main() -> None:
    env = Environment()
    agents = [BMSmithy(), BigMoney()]

    results = [env.run_game(agents) for _ in range(1000)]
    for i, agent in enumerate(agents):
        wins = sum(1 for game in results if game.winner == i)
        average_vp = sum(game.scores[i] for game in results) * 1.0 / 1000
        print(f"\n{agent.__class__.__name__}:\n  Wins: {wins}\n  Average VP: {average_vp}")


if __name__ == "__main__":
    main()
