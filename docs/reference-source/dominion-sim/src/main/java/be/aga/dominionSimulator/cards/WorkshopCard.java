package be.aga.dominionSimulator.cards;

import be.aga.dominionSimulator.DomCard;
import be.aga.dominionSimulator.DomCost;
import be.aga.dominionSimulator.DomPlayer;
import be.aga.dominionSimulator.enums.DomCardName;
import be.aga.dominionSimulator.enums.DomCardType;

import java.util.ArrayList;

public class WorkshopCard extends DomCard {
    public WorkshopCard () {
      super( DomCardName.Workshop);
    }

    public void play() {
      doWorkshop(owner);
    }

    public static void doWorkshop(DomPlayer domPlayer) {
        if (domPlayer.isHumanOrPossessedByHuman()) {
            ArrayList<DomCardName> theChooseFrom = new ArrayList<>();
            for (DomCardName theCard : domPlayer.getCurrentGame().getBoard().getTopCardsOfPiles()) {
                if (new DomCost(4,0).customCompare(theCard.getCost(domPlayer.getCurrentGame()))>=0 && domPlayer.getCurrentGame().countInSupply(theCard)>0 )
                    theChooseFrom.add(theCard);
            }
            if (theChooseFrom.isEmpty())
                return;
            domPlayer.gain(domPlayer.getCurrentGame().takeFromSupply(domPlayer.getEngine().getGameFrame().askToSelectOneCard("Select card to gain for "+ DomCardName.Workshop.toHTML(), theChooseFrom, "Mandatory!")));
        }else {
            DomCardName theDesiredCard = domPlayer.getDesiredCard(new DomCost(4, 0), false);
            if (theDesiredCard == null) {
                //possible to get here if card was throne-roomed
                theDesiredCard = domPlayer.getCurrentGame().getBestCardInSupplyFor(domPlayer, null, new DomCost(4, 0));
            }
            if (theDesiredCard != null)
                domPlayer.gain(theDesiredCard);
        }
    }

    @Override
    public boolean wantsToBePlayed() {
       return owner.getDesiredCard(new DomCost( 4, 0), false) != null ;
    }

    @Override
    public int getPlayPriority() {
        if (owner.getDrawDeckSize()==0 && owner.getActionsAndVillagersLeft()>1 && !owner.getCardsFromHand(DomCardType.Cycler).isEmpty())
            return 1;
        return super.getPlayPriority();
    }
}