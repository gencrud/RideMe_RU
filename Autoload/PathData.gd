extends Node
class_name PathData

# game process
const PATH_GAME = "/root/Game"
const PATH_PLAYER = PATH_GAME + "/Player"
const PATH_GUI = "/root/Game/GUI/Canvas"
const PATH_GAME_SCREEN_PAUSE = PATH_GUI + "/GameScreenPause"
const PATH_LIVES_COUNTER = PATH_GUI + "/Counters/LivesCounter"
const PATH_LIVES_COUNTER_VALUE = PATH_LIVES_COUNTER + "/Background/Value"
const PATH_RMS_COUNTER = PATH_GUI + "/Counters/RMCounter"
const PATH_RMS_COUNTER_VALUE = PATH_RMS_COUNTER + "/Background/Value"
const PATH_TIMEOUT = PATH_GUI + "/Counters/Timeout"
const PATH_TIME_LEVEL_VALUE = PATH_TIMEOUT + "/Background/Value"
const PATH_SPEED_BAR = PATH_GUI + "/HBoxContainer/Bars/SpeedBar"
const PATH_POWER_BAR = PATH_GUI + "/HBoxContainer/Bars/PowerBar"
const PATH_GUI_TIME = PATH_GUI + "/HBoxContainer/Time"
const PATH_SPEED_BAR_COUNT_VALUE = PATH_SPEED_BAR + "/Count/Background/Value"
const PATH_POWER_BAR_COUNT_VALUE = PATH_POWER_BAR + "/Count/Background/Value"
const PATH_JUMP_BTN = PATH_GUI + "/ControlContainer/JumpBtn"
const PATH_GO_BTN = PATH_GUI + "/ControlContainer/GoBtn"
const PATH_STOP_BTN = PATH_GUI + "/ControlContainer/StopBtn"

# resources
# const END_GAME_SCREEN = "res://Game/GameScreen/EndGameScreen.tscn"
const BIKE_MENU_SCREEN = "res://Menu/BikeMenu/BikeMenu.tscn"
const RES_MAIN_MENU_TSCN = "res://Menu/MainMenu/MainMenu.tscn"
const RES_LEVEL_MENU_TSCN = "res://Menu/LevelMenu/LevelMenu.tscn"
const RES_OPTION_MENU_TSCN = "res://Menu/OptionMenu/OptionMenu.tscn"
const RES_GAME_SCREEN_PAUSE = "res://Game/GameScreen/GameScreenPause.tscn"

# levels
const PATH_GAME_LEVEL = "res://Game/Level/"
const PATH_LEVEL_0 = PATH_GAME_LEVEL + "Level_0/Level_0.tscn"
const PATH_LEVEL_1 = PATH_GAME_LEVEL + "Level_1/Level_1.tscn"
const PATH_LEVEL_2 = PATH_GAME_LEVEL + "Level_2/Level_2.tscn"

# levels' models
const _PATH_MODEL = "res://config/"
const BIKE_MODEL = _PATH_MODEL + "BikeCfg.gd"
const PLAYER_BIKE_MODEL = _PATH_MODEL + "PlayerBikeCfg.gd"
const LEVEL_MODEL = _PATH_MODEL + "LevelCfg.gd"
const TRACK_MODEL = _PATH_MODEL + "TrackCfg.gd"
const PLAYER_TRACK_MODEL = _PATH_MODEL + "PlayerTrackCfg.gd"

# scripts
const PATH_DIE_PLAYER = "res://Game/scripts/DiePlayer.gd"
const PATH_PAUSE_DIE = "res://Game/GameScreen/GamePauseDie.gd"
const PATH_PLAYER_STOMP_DETECTER = "res://Game/scripts/PlayerStompDetecter.gd"
const PATH_ANIMATE_PEOPLE = "res://Game/Character/People/scripts/AnimatePeople.gd"
