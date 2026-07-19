from dominion.agents.big_money import BigMoney
from dominion.cardsets.base import PROVINCE, SILVER
from dominion.game import Game
from dominion.moves import BuyCard, EndActionPhase, EndBuyPhase
from dominion.state import Phase


def test_big_money_always_ends_action_phase():
    game = Game()

    agent = BigMoney()
    move = agent.choose(game.state, game.legal_moves())

    assert isinstance(move, EndActionPhase)

def test_big_money_buys_province_if_possible():
    game = Game()
    player = game.active_player
    game.state.phase = Phase.BUY

    player.coins = 8
    player.buys = 1

    agent = BigMoney()
    move = agent.choose(game.state, game.legal_moves())

    assert isinstance(move, BuyCard)
    assert move.card is PROVINCE


def test_big_money_buys_money_over_actions():
    game = Game()
    player = game.active_player
    game.state.phase = Phase.BUY

    player.coins = 4
    player.buys = 1

    agent = BigMoney()
    move = agent.choose(game.state, game.legal_moves())

    assert isinstance(move, BuyCard)
    assert move.card is SILVER


def test_big_money_does_not_buy_copper():
    game = Game()
    player = game.active_player
    game.state.phase = Phase.BUY

    player.coins = 2
    player.buys = 1

    agent = BigMoney()
    move = agent.choose(game.state, game.legal_moves())

    assert isinstance(move, EndBuyPhase)
