function MoveStageAndWait(Stage,Height,MaxH)

%Moves stage and continues only when stage has stoped moving

if Height>MaxH error('FinalHeight too small'); end
Stage.SetAbsMovePos(0,Height);
Stage.MoveAbsolute(0,1==0);
while(IsMoving(Stage))
end
    