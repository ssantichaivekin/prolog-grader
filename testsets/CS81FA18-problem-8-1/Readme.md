Problem 1 asks us to implement
- newTape(OldTape, Character, NewTape) : 
    Removing character from the oldtape produces a new tape.
- newStack(OldStack, TopCharacter, NewCharacter, NewStack) :
    Replace the top character of the old stack with the new character.
    If TopCharacter is epsilon, we do a push.
    If NewCharacter is epsilon, we do a pop.