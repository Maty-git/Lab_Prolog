/*
player(Id, Name, Color, Win, Losses, Draws, Piezas, [Id, Name, Color, Win, Losses, Draws, Piezas]).

*/
getplayer([_, Name, _, _, _, _, _], Name).


player(Id, Name, Color, Win, Losses, Draws, Piezas, Player):-
    Player = [Id, Name, Color, Win, Losses, Draws, Piezas].
