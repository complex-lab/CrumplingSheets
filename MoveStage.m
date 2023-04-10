function MoveStage(Stage,Height,MaxH)

if Height>MaxH error('FinalHeight too small'); end
Stage.SetAbsMovePos(0,Height);
Stage.MoveAbsolute(0,1==0);