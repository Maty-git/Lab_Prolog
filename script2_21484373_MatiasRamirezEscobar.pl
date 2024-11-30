
% Importar los archivos
:- consult('piece_21484373_MatiasRamirezEscobar.pl').
:- consult('player_21484373_MatiasRamirezEscobar.pl').
:- consult('board_21484373_MatiasRamirezEscobar.pl').
:- consult('game_21484373_MatiasRamirezEscobar.pl').

% Ejemplo de un predicado donde hay victoria diagonal
main :-
    % 1. Crear jugadores (10 fichas cada uno para un juego corto)
	player(1, "Juan", "red", 0, 0, 0, 5, P1),
	player(2, "Mauricio", "yellow", 0, 0, 0, 5, P2),
	% 2. Crear fichas
	piece("red", RedPiece),
	piece("yellow", YellowPiece),
	% 3. Crear tablero inicial vac�o
	board(EmptyBoard),
	% 4. Crear nuevo juego
	game(P1, P2, EmptyBoard, 1, G0),
	% 5. Realizando movimientos para crear una victoria diagonal
	player_play(G0, P1, 3, G1),    % Juan juega en columna 3
	player_play(G1, P2, 5, G2),    % Mauricio juega en columna 5
	player_play(G2, P1, 6, G3),    % Juan juega en columna 6
	player_play(G3, P2, 7, G4),    % Mauricio juega en columna 7
	player_play(G4, P1, 6, G5),    % Juan juega en columna 6
	player_play(G5, P2, 5, G6),    % Mauricio juega en columna 5
	player_play(G6, P1, 6, G7),    % Juan juega en columna 6
	player_play(G7, P2, 6, G8),    % Mauricio juega en columna 6
	player_play(G8, P1, 1, G9),    % Juan juega en columna 1
	player_play(G9, P2, 2, G10),   % Mauricio juega en columna 2 (empate)


	% 6. Verificaciones del estado del juego
	write('Se puede jugar en el tablero vacio? '),
	can_play(EmptyBoard), % Si se puede seguir jugando, el programa continuar�
	nl,
	game_get_board(G10, CurrentBoard),
	write('Se puede jugar despues de 10 movimientos? '),
	can_play(CurrentBoard),
	nl,

    write('Jugador actual despues de 10 movimientos: '),
    get_current_player(G10, CurrentPlayer),
    write(CurrentPlayer),
    nl,

	% 7. Verificaciones de victoria
	write('Verificacion de victoria vertical: '),
	check_vertical_win(CurrentBoard, VerticalWinner),
	write(VerticalWinner),
	nl,

	write('Verificacion de victoria horizontal: '),
	check_horizontal_win(CurrentBoard, HorizontalWinner),
	write(HorizontalWinner),
	nl,

	write('Verificacion de victoria diagonal: '),
	check_diagonal_win(CurrentBoard, DiagonalWinner),
	write(DiagonalWinner),
	nl,

	write('Verificacion de ganador: '),
	who_is_winner(CurrentBoard, Winner),
	write(Winner),
	nl,

	% 8. Verificaci�n de empate
	write('Es empate? '),
	( is_draw(G10) -> writeln('Si es empate');  writeln('No es empate')),
	nl,

	% 10. Mostrar historial de movimientos
	write('Historial de movimientos: '),nl,
	game_history(G10, History),
	write(History),
	nl,

	% 11. Mostrar estado final del tablero
	write('Estado final del tablero: '),nl,
	game_get_board(G10, FinalBoard),
	write(FinalBoard).

