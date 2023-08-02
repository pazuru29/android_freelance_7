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