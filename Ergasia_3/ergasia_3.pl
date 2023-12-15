% Database of flights between two cities.
timetable(edinburgh, london, [
								[ depTime(09,40), arrTime(10,50), ba4773, alldays ],
								[ depTime(19,40), arrTime(20,50), ba4833, [mo,tu,we,th,fr,su] ]
]).

timetable(london, edinburgh, [
								[ depTime(09,40), arrTime(10,50), ba4732, alldays ],
								[ depTime(18,40), arrTime(19,50), ba4822, [mo,tu,we,th,fr] ]
]).

timetable(london, athens, [
								[ depTime(13,20), arrTime(16,20), ju201, [fr] ],
								[ depTime(13,20), arrTime(16,20), ju213, [su] ]
]).

timetable(london, zurich, [
								[ depTime(09,10), arrTime(11,45), ba614, alldays ],
								[ depTime(14,45), arrTime(17,20), sr805, alldays ]
]).

timetable(london, milan, [
								[ depTime(08,30), arrTime(11,20), ba510, alldays ],
								[ depTime(11,00), arrTime(13,50), a2459, alldays ]
]).

timetable(athens, zurich, [
								[ depTime(11,30), arrTime(12,40), ju322, [tu,th] ]
]).

timetable(athens, london, [
								[ depTime(11,10), arrTime(12,20), yu200, [fr] ],
								[ depTime(11,25), arrTime(12,20), yu212, [su] ]
]).

timetable(milan, london, [
								[ depTime(09,10), arrTime(10,00), a2458, alldays ],
								[ depTime(12,20), arrTime(13,10), ba511, alldays ]
]).

timetable(milan, zurich, [
								[ depTime(09,25), arrTime(10,15), sr621, alldays ],
								[ depTime(12,45), arrTime(13,35), sr623, alldays ]
]).

timetable(zurich, athens, [
								[ depTime(13,30), arrTime(14,40), yu323, [tu,th] ]
]).

timetable(zurich, london, [
								[ depTime(09,00), arrTime(09,40), ba613, [mo,tu,we,th,fr,sa] ],
								[ depTime(16,10), arrTime(16,55), sr806, [mo,tu,we,th,fr,su] ]
]).

timetable(zurich, milan, [
								[ depTime(07,55), arrTime(08,45), sr620, alldays ]
]).

% timetable(Place1, Place2, [ [depTime(Hour1, Minute1), arrTime(Hour2, Minute2), FlightNum, Days] ]) ->
% contains the flight information from Place1 to Place2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Direct flight from Place1 to Place2 on given Day.
route(Place1, Place2, Day, [Place1, Place2, Day, FlightNum, DepTime]) :- flight(Place1, Place2, Day, FlightNum, DepTime, _).

% flight(Place1, Place2, Day, FlightNum, DepTime, _) -> check if there is a flight from Place1
% to Place2 on the given Day and save the flight number and departure time in the variables
% FlightNum and DepTime.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Indirect flight from Place1 to Place2 on given Day.
route(Place1, Place2, Day, Routes) :-
	route(IntermediatePlace, Place2, Day, FinalFlight),
	flight(Place1, IntermediatePlace, Day, FlightNum, _, ArrTime),
	IntermediateFlight = [Place1, IntermediatePlace, Day, FlightNum, ArrTime],
	append([IntermediateFlight], [FinalFlight], Routes),
	deptime(FinalFlight, DepTime),
	transfer(ArrTime, DepTime), !.

% route(IntermediatePlace, Place2, Day, FinalFlight) -> check if there is a flight from
% IntermediatePlace to Place2 on the given Day and save the flight in the variable FinalFlight.

% flight(Place1, IntermediatePlace, Day, FlightNum, _, ArrTime) -> check if there is a flight
% from Place1 to IntermediatePlace on the given Day and save the flight number and arrival time
% in the variables FlightNum and ArrTime.

% IntermediateFlight = [Place1, IntermediatePlace, Day, FlightNum, ArrTime] -> create a list
% with the intermediate flight information.

% append([IntermediateFlight], [FinalFlight], Routes) -> append the intermediate flight list
% and the final flight list to the Routes list.

% deptime(FinalFlight, DepTime) -> save the departure time of the final flight in the variable
% DepTime.

% transfer(ArrTime, DepTime) -> % check if a transfer time of at least 40 minutes exists between
% the arrival time of the intermediate flight and the departure time of the final flight.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Return the flight between Place1 and Place2 on the given Day, FlightNum, DepTime and ArrTime.
flight(Place1, Place2, Day, FlightNum, DepTime, ArrTime) :-
    timetable(Place1, Place2, Flights),
    member([DepTime, ArrTime, FlightNum, DayTemp], Flights),
	(DayTemp == alldays, member(Day, [mo,tu,we,th,fr,sa,su]) ; member(Day, DayTemp)).

% timetable(Place1, Place2, Flights) -> check if the timetable contains a flight between
% Place1 and Place2 and save the list of flights in the variable Flights.

% member([DepTime, ArrTime, FlightNum, DayTemp], Flights) -> check if the Flights list
% contains a flight with the given DepTime, ArrTime and FlightNum and save in the variable
% DayTemp the days that the flight is available.

% (DayTemp == alldays, member(Day, [mo,tu,we,th,fr,sa,su]) ; member(Day, DayTemp)) -> check if
% the DayTemp list contains the given Day. If the DayTemp == alldays then the flight is available
% on all days of the week.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Return the departure time of a flight.
deptime([_, _, _, _, DepTime], DepTime).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check if Time1 and Time2 have a transfer time of at least 40 minutes.
transfer(Time1, Time2) :- 
	Time1 = arrTime(H1,M1), Time2 = depTime(H2,M2),
	TotalM1 is  H1*60 + M1, TotalM2 is H2*60 + M2,
	TotalM2-TotalM1 >= 40.

% Time1 = arrTime(H1,M1) -> extract the hour and minute values of Time1 which is 
% in the form of arrTime(H1,M1) and assigns H1 to the hour and M1 to the minute.

% Time2 = depTime(H2,M2) -> extract the hour and minute values of Time2 which is 
% in the form of depTime(H2,M2) and assigns H2 to the hour and M2 to the minute.

% TotalM1 is  H1*60 + M1 -> converts the hours and minutes of Time1 into total minutes.

% TotalM2 is  H2*60 + M2 -> converts the hours and minutes of Time2 into total minutes.

% M2-M1 >= 40 ->  check if the difference between M1 and M2 is greater than or equal to 40.