//Paddings
const double kHorizontalPadding = 20;

//Shared prefs keys
///Active match -- bool
const String kSimpleScoreBarActive = 'simpleScoreBarActive';
const String kSportScoreBarActive = 'sportScoreBarActive';
const String kWorkoutActive = 'workoutActive';

//Simple score bar
///Numbers of players -- int
const String kSimpleScoreBarNumberOfPlayers = 'simpleScoreBarNumberOfPlayers';

///Name of teams -- String
const String kSimpleScoreBarNameTeam1 = 'simpleScoreBarNameTeam1';
const String kSimpleScoreBarNameTeam2 = 'simpleScoreBarNameTeam2';
const String kSimpleScoreBarNameTeam3 = 'simpleScoreBarNameTeam3';
const String kSimpleScoreBarNameTeam4 = 'simpleScoreBarNameTeam4';

///Score of team -- int
const String kSimpleScoreBarScoreTeam1 = 'simpleScoreBarScoreTeam1';
const String kSimpleScoreBarScoreTeam2 = 'simpleScoreBarScoreTeam2';
const String kSimpleScoreBarScoreTeam3 = 'simpleScoreBarScoreTeam3';
const String kSimpleScoreBarScoreTeam4 = 'simpleScoreBarScoreTeam4';

///Max time of match -- int
const String kSimpleScoreBarTime = 'simpleScoreBarTime';

///Timer state: 0 - init, 1 - active, 2 - pause, 3 - finished -- int
const String kSimpleScoreBarTimerState = 'simpleScoreBarTimerState';

///Settings for save data when user out from app
///double
const String kSimpleScoreBarRemainingTime = 'simpleScoreBarRemainingTime';

///String
const String kSimpleScoreBarDateTime = 'simpleScoreBarDateTime';

//Workout Timer
///Timer state: 0 - init, 1 - active, 2 - pause, 3 - finished -- int
const String kWorkoutTimerState = 'workoutTimerState';

///double
const String kWorkoutRemainingTime = 'workoutRemainingTime';

///String
const String kWorkoutDateTime = 'workoutDateTime';

///List<String>
const String kWorkoutListOfTime = 'workoutListOfTime';

///int
const String kWorkoutCurrentTimer = 'workoutCurrentTimer';

//Sport
///int - 1 - 8 | Soccer - Handball
const String kSportType = 'sportType';

///Timer state: 0 - init, 1 - active, 2 - pause, 3 - finished -- int
const String kSportMainTimerState = 'sportMainTimerState';

///int
const String kSportMainTimerTime = 'sportMainTimerTime';

///double
const String kSportMainRemainingTime = 'sportMainRemainingTime';

///String
const String kSportDateTime = 'sportDateTime';

///String
const String kSportNameTeam1 = 'sportNameTeam1';
const String kSportNameTeam2 = 'sportNameTeam2';

///int
const String kSportScoreTeam1 = 'sportScoreTeam1';
const String kSportScoreTeam2 = 'sportScoreTeam2';

//Sport - Chess
///Timer state: 0 - init, 1 - active, 2 - pause, 3 - finished -- int
const String kSportSecondTimerState = 'sportSecondTimerState';

///int
const String kSportSecondTimerTime = 'sportSecondTimerTime';

///double
const String kSportSecondRemainingTime = 'sportSecondRemainingTime';

//Sport - Soccer/Basketball
const String kSportFoulsTeam1 = 'sportFoulsTeam1';
const String kSportFoulsTeam2 = 'sportFoulsTeam2';

//Sport Tennis
const String kSportGameCountTeam1 = 'sportGameCountTeam1';
const String kSportGameCountTeam2 = 'sportGameCountTeam2';

const String kSportSetsCountTeam1 = 'sportSetsCountTeam1';
const String kSportSetsCountTeam2 = 'sportSetsCountTeam2';
